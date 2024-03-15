import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.text.NumberFormat;
import java.util.Locale;

public class renderPlainText {
    public JSONObject plays;
    public JSONArray invoices;
    public renderPlainText(JSONArray invoices,JSONObject plays){
        this.invoices = invoices;
        this.plays = plays;
    }
    public String getAllStatement(){
        String result = "";
        for (Object o : this.invoices) {
            JSONObject invoice = (JSONObject) o;

            result = statement(invoice);
        }
        return result;
    }

    // Extract Function
    public int amountFor(JSONObject aPerformance) {
        int result;

        switch ((String) playFor(aPerformance).get("type")) {
            case "romantic" -> {
                result = 40000;
                if ((long) aPerformance.get("audience") > 30) {
                    result += 1000 * ((long) aPerformance.get("audience") - 30);
                }
            }
            case "comedy" -> {
                result = 30000;
                if ((long) aPerformance.get("audience") > 20) {
                    result += 10000 + 500 * ((long) aPerformance.get("audience") - 20);
                }
                result += 300 * (long) aPerformance.get("audience");
            }
            default -> throw new Error("Unknow Type " + playFor(aPerformance).get("type"));
        }

        return result;
    }

    // Replace Temp with Query - play
    public JSONObject playFor(JSONObject bPerformance) {
        String id = (String) bPerformance.get("playID");
        return (JSONObject) this.plays.get(id);
    }

    // Extract Function -Volumn Credits
    public int volumeCreditsFor(JSONObject cPerformance) {
        int volumeCredits = 0;
        // add volume credits
        volumeCredits += Math.max((long) cPerformance.get("audience") - 30, 0);
        String type = (String) playFor(cPerformance).get("type");
        // add extra credit for every ten romantic attendees
        if (type.equals("romantic")) {
            volumeCredits += Math.floor((long) cPerformance.get("audience") / 5);
        }
        return volumeCredits;
    }

    // Change Function Declaration + Inline Variables - number/money format
    public String usd(double number){
        return NumberFormat.getInstance(new Locale("en", "US")).format(number);
    }

    // Split loop - Slide Statements - Extract Function - Inline Variables
    public int totalVolumeCredits(JSONArray dPerformances){
        int volumeCredits = 0;
        for (Object performance : dPerformances) {
            JSONObject perf = (JSONObject) performance;
            volumeCredits += volumeCreditsFor(perf);
        }
        return volumeCredits;
    }
    public int totalAmount(JSONArray ePerformances){
        int totalAmount=0;
        for (Object performance : ePerformances) {
            JSONObject perf = (JSONObject) performance;

            totalAmount += amountFor(perf);
        }
        return totalAmount;
    }

    public StringBuilder billForEach(JSONArray fPerformances, StringBuilder result){
        for (Object performance : fPerformances) {
            JSONObject perf = (JSONObject) performance;
            result.append(" ")
                    .append((String) playFor(perf).get("name")).append(" : $")
                    .append(usd(amountFor(perf) / 100)).append(" (")
                    .append((long) perf.get("audience")).append(")\n");
        }
        return result;
    }

    public String statement(JSONObject invoice) {
        StringBuilder result = new StringBuilder("Statement for " + invoice.get("customer") + "\n");
        JSONArray performances = (JSONArray) invoice.get("performances");

        // Get statement for each performace
        result = billForEach(performances,result);

        result.append("Amount owed is $").append(usd(totalAmount(performances) / 100)).append("\n");
        result.append("You earned ").append(totalVolumeCredits(performances)).append(" credits\n");
        return result.toString();
    }
}

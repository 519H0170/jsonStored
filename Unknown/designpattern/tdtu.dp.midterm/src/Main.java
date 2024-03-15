import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.nio.file.FileSystems;
import java.nio.file.Path;

public class Main {
    public static Path path = FileSystems.getDefault().getPath("src").toAbsolutePath();
    public static JSONParser parser = new JSONParser();
    public static JSONObject plays = readFile_jsonObject("plays.json");
    public static JSONArray invoices = readFile_jsonArray("invoices.json");

    public static JSONArray readFile_jsonArray(String filename) {
        try (Reader reader = new FileReader(path + "/data/" + filename)) {
            // Inline variable Refactoring
            return (JSONArray) parser.parse(reader);
        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
        return new JSONArray();
    }

    public static JSONObject readFile_jsonObject(String filename) {
        try (Reader reader = new FileReader(path + "/data/" + filename)) {
            // Inline variable Refactoring
            return (JSONObject) parser.parse(reader);
        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
        return new JSONObject();
    }

    public static void main(String[] args) {
        if (plays.size() > 0 && invoices.size() > 0) {

            renderPlainText render = new renderPlainText(invoices,plays);
            System.out.println(render.getAllStatement());
        }
    }
}


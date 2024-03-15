# Group10 T5CA1

## How to Use
1. **Software Requirement:** 
   - Use Android Studio software to run the program.

2. **Actions with Design Pattern Participation:**
   - The following activities involve the design pattern:
     - SignUpAct
     - LogInAct
     - CreateTruyen
     - TruyenChiTiet

3. **To Run Actions:**
   - Open the file `AndroidManifest.xml`.
   - For activities to run, ensure the following configuration:
     - **Run:**
       ```xml
       <activity
           android:name=".TruyenChiTiet"
           android:exported="true">
           <intent-filter>
               <action android:name="android.intent.action.MAIN" />
               <category android:name="android.intent.category.LAUNCHER" />
           </intent-filter>
       </activity>
       ```
     - **Do Not Run:**
       ```xml
       <activity
           android:name=".SignUpAct"
           android:exported="false">
           <meta-data
               android:name="android.app.lib_name"
               android:value="" />
       </activity>
       ```

**Note:** Ensure proper configuration in the AndroidManifest.xml file for each activity according to the provided instructions.

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Collections;
import java.util.LinkedList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class FindRoute {


    private LinkedList<Node> parseJson(File jsonFile) {
        JSONParser parser = new JSONParser();
        Object object = null;
        LinkedList<Node> listePato = new LinkedList<>();


        try {
            object = parser.parse(new FileReader(jsonFile));
        } catch (FileNotFoundException e) {
            System.out.println("Fichier introuvable ! \n");
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        }

        JSONObject jsonObject = (JSONObject) object;
        JSONArray features = (JSONArray) jsonObject.get("features");

        for (Object pool : features) {
            JSONObject jsonPool = (JSONObject) pool;
            JSONObject proprietePato = (JSONObject) jsonPool.get("properties");
            JSONObject geometry = (JSONObject) jsonPool.get("geometry");

            int parkId = ((Long) proprietePato.get("PARK_ID")).intValue();
            int facilityId = ((Long) proprietePato.get("FACILITYID")).intValue();
            String poolName = proprietePato.get("NAME").toString().replace("Wading Pool - ", "");
            Object[] coordsArray = ((JSONArray) geometry.get("coordinates")).toArray();
            double latitude = (double) coordsArray[0];
            double longitude = (double) coordsArray[1];

            Node poolObj = new Node(parkId, facilityId, poolName, latitude, longitude);
            listePato.add(poolObj);
        }

        Collections.sort(listePato);



        return listePato;
    }

    public static void main(String[] args) {
        File jsonFile = new File(args[0]);
        FindRoute chemin = new FindRoute();
        LinkedList<Node> listePato = chemin.parseJson(jsonFile);
        Tree tree = new Tree(listePato);
        System.out.println("\n\n");
        tree.traverse();
    }

}

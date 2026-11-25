package Efficient;
import java.io.*;
import java.util.*;

public class Main {

    public static void main(String[] args) throws Exception {

        List<NetworkRecord> dataset = new ArrayList<>();

        BufferedReader br =
                new BufferedReader(
                new FileReader(
                "network_anomaly_dataset_records.csv"));

        String line;

        br.readLine(); // skip header

        while((line = br.readLine()) != null) {

            String[] data = line.split(",");

            double[] features = new double[10];

            for(int i=0;i<10;i++) {
                features[i] =
                        Double.parseDouble(data[i]);
            }

            String label = data[10];

            dataset.add(
                new NetworkRecord(
                        features,label));
        }

        br.close();

        KNNClassifier knn =
                new KNNClassifier(dataset,5);

        double[] testInput = {

                18,
                2712,
                204794,
                4,
                18,
                232,
                5,
                6,
                24.03,
                19
        };

        String result =
                knn.predict(testInput);

        System.out.println(
                "Predicted Attack Type : "
                + result);
    }
}
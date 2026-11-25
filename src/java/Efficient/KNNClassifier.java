package Efficient;
import java.util.*;

public class KNNClassifier {

    private List<NetworkRecord> trainingData;
    private int k;

    public KNNClassifier(List<NetworkRecord> trainingData, int k) {
        this.trainingData = trainingData;
        this.k = k;
    }

    private double distance(double[] a, double[] b) {

        double sum = 0;

        for(int i=0;i<a.length;i++) {
            sum += Math.pow(a[i]-b[i],2);
        }

        return Math.sqrt(sum);
    }

    public String predict(double[] input) {

        List<Neighbor> neighbors = new ArrayList<>();

        for(NetworkRecord record : trainingData) {

            double dist = distance(input, record.features);

            neighbors.add(
                new Neighbor(dist, record.label)
            );
        }

        Collections.sort(neighbors);

        Map<String,Integer> votes = new HashMap<>();

        for(int i=0;i<k;i++) {

            String label = neighbors.get(i).label;

            votes.put(
                label,
                votes.getOrDefault(label,0)+1
            );
        }

        String prediction = "";
        int maxVotes = 0;

        for(String label : votes.keySet()) {

            if(votes.get(label) > maxVotes) {

                maxVotes = votes.get(label);
                prediction = label;
            }
        }

        return prediction;
    }

    class Neighbor implements Comparable<Neighbor> {

        double distance;
        String label;

        Neighbor(double distance, String label) {
            this.distance = distance;
            this.label = label;
        }

        @Override
        public int compareTo(Neighbor o) {
            return Double.compare(this.distance, o.distance);
        }
    }
}
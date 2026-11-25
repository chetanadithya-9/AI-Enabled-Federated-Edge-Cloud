package Efficient;

public class NetworkAttackPredictor {

    public static String predictAttack(
            int duration_sec,
            int packet_count,
            int bytes_transferred,
            int flow_rate,
            int failed_logins,
            int syn_packets,
            int udp_packets,
            int tcp_retransmissions,
            double avg_packet_size,
            int connection_hour) {

        // DDoS
        if (packet_count > 2000 &&
            syn_packets > 200 &&
            failed_logins >= 5) {

            return "DDoS";
        }

        // Botnet
        if (duration_sec > 30 &&
            packet_count > 1000 &&
            bytes_transferred > 20000 &&
            syn_packets < 50) {

            return "Botnet";
        }

        // PortScan
        if (packet_count >= 500 &&
            packet_count <= 2000 &&
            syn_packets >= 50 &&
            syn_packets <= 200 &&
            failed_logins >= 10) {

            return "PortScan";
        }

        return "Normal";
    }

    public static void main(String[] args) {

        String attack = predictAttack(
                111,      // duration_sec
                3859,     // packet_count
                75392,    // bytes_transferred
                20,       // flow_rate
                7,        // failed_logins
                49,       // syn_packets
                13,       // udp_packets
                10,       // tcp_retransmissions
                11.12,    // avg_packet_size
                12        // connection_hour
        );

        System.out.println("Predicted Attack: " + attack);
    }
}
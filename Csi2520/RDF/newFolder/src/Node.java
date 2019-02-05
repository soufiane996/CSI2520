import java.util.LinkedList;

public class Node implements Comparable<Node>{

    public int parkId;
    public int facilityId;
    public String nom_park;
    public double longitude, latitude;
    private LinkedList<Edge> e;
    public Edge parentEdge = null;

    public Node(int parkId, int facilityId, String nom_park, double longitude, double latitude) {
        this.parkId = parkId;
        this.facilityId = facilityId;
        this.nom_park = nom_park;
        this.latitude = latitude;
        this.longitude = longitude;
        this.e = new LinkedList<>();
    }

    // This will be used to sort the list of pools.
    /*
        Sert a trier la liste des patog
        le patogeoire avec la plus petite longitude est le plus a l'ouest
        nous permet de trier de l'est a l'ouest
    */

    public int compareTo(Node otherPool) {
        if (this.longitude > otherPool.longitude) {
            return 1;
        } else if (this.longitude == otherPool.longitude) {
            return 0;
        } else {
            return -1;
        }
    }

    public LinkedList<Edge> getE() {
        return e;
    }

}

import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.LinkedList;
import java.util.Stack;

public class Tree {

    private static final double CONST = 6371.0;
    private static final double RADIAN_CONST = 180.0;

    public Node root;
    private LinkedList<Node> poolList;
    private LinkedList<Node> connectedNodes;

    public Tree(LinkedList<Node> poolList) {
        this.poolList = poolList;
        connectedNodes = new LinkedList<>();


        //Le plus ouest doit etre le root
        //Liste triee pour que le permier element soit le plus a ouest
        root = poolList.get(0);
        connectedNodes.add(root);
        poolList.remove(0);
        System.out.println("ROOT: " + root.nom_park + ", " + root.longitude);

        // Find the closest node to the root from the poolList
        double smallestDist = 9999;
        Node secondNode = null;
        for (int i = 0; i < poolList.size(); i++) {
            double tempDist = calculateDistance(root, poolList.get(i));

            // If the calculated distance is less than the smallest distance so far
            if (tempDist < smallestDist) {
                smallestDist = tempDist;
                secondNode = poolList.get(i);
            }
        }

        //Lier la deuxieme node une fois trouvee
        Double calculated_distance = calculateDistance(root, secondNode);
        Edge rootEdge = new Edge(root, secondNode,calculated_distance );
        secondNode.parentEdge = rootEdge;
        root.getE().add(rootEdge);
        connectedNodes.add(secondNode);
        poolList.remove(secondNode);

        System.out.println("\n\nCONNECTION ROOT!");
        System.out.println("Parent: " + rootEdge.parent.nom_park);
        System.out.println("Child: " + rootEdge.enfant.nom_park);
        System.out.println("Dist: " + rootEdge.distance);
        System.out.println("Connectednodes size: " + connectedNodes.size());

        // Construire l'arbre
        // Parcourir a travers la liste et comparer les elements
        // Commence a 1 vu que root est 0
        for (int i = 0; i < poolList.size(); i++) {
            Node closestPool = findClosestPool(poolList.get(i));
            double dist = calculateDistance(poolList.get(i), closestPool);
            Edge newEdge = new Edge(closestPool, poolList.get(i), dist);
            closestPool.getE().add(newEdge);
            poolList.get(i).parentEdge = newEdge;
            connectedNodes.add(poolList.get(i));
            System.out.println("\n\nCONNECTION!");
            System.out.println("Parent: " + closestPool.nom_park);
            System.out.println("Child: " + poolList.get(i).nom_park);
            System.out.println("Dist: " + dist);
            System.out.println("Connectednodes size: " + connectedNodes.size());
        }
    }

    public double calculateDistance(Node node1, Node node2) {

        double lat1 = degreesToRadians(node1.latitude);
        double lat2 = degreesToRadians(node2.latitude);
        double lon1 = degreesToRadians(node1.longitude);
        double lon2 = degreesToRadians(node2.longitude);

        double a1 = Math.pow(Math.sin((lat1 - lat2) / 2), 2);
        double a2 = Math.cos(lat1) * Math.cos(lat2);
        double a3 = Math.pow(Math.sin((lon1 - lon2) / 2), 2);

        double dRad = 2 * Math.asin( Math.sqrt(a1 + (a2 * a3)) );

        return CONST * dRad;
    }

    private static double degreesToRadians(double angle) {
        return (Math.PI / RADIAN_CONST) * angle;
    }

    private Node findClosestPool(Node pool) {
        double smallestDist = 9999;
        Node closestPool = null;

        for (int i = 0; i < connectedNodes.size(); i++) {
            Node currentPool = connectedNodes.get(i);
            // S'assurer qu'on ne compare pas les memes pools
            if (pool.parkId != currentPool.parkId) {
                double tempDist = calculateDistance(pool, currentPool);

                // If the calculated distance is less than the smallest distance so far
                if (tempDist < smallestDist) {
                    smallestDist = tempDist;
                    closestPool = connectedNodes.get(i);

                }
            }
        }
        return closestPool;
    }

    public void traverse() {
        PrintWriter writer;
        Stack<Node> poolStack = new Stack<>();
        poolStack.push(root);
        double currentDist = 0;
        System.out.println(root.getE());

        try {
            writer = new PrintWriter("findRouteOut.txt", "UTF-8");

            // starting with the root.
            //Iterate on the tree
            // Pop the current node and push each child node into the stack.
            while (!poolStack.isEmpty()) {
                Node currentNode = poolStack.pop();

                if (currentNode != root) {
                    currentDist += currentNode.parentEdge.distance;
                }
                System.out.println(currentNode.nom_park + " " + currentDist);
                writer.println(currentNode.nom_park + " " + currentDist);

                if (!currentNode.getE().isEmpty()) {
                    for (int i = currentNode.getE().size() - 1; i >= 0; i--) {
                        poolStack.push(currentNode.getE().get(i).enfant);
                    }
                }
            }

            writer.close();

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

    }


}

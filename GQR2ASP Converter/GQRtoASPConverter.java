import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

/**
 *
 */
public class GQRtoASPConverter {

    static String base_folder = "";
    static String calculus = "";
    static String encoding = "";

    static boolean axiom_R6 = false; 
    static boolean axiom_R7 = false; 
    
    static String comp_table_file = ""; 
    static String converse_file = ""; 
    static String identity = ""; 
    static int calculus_size = 0;

    /**
     * This function parses the arguments that are provided through command line
     * 
     * @param args 
     */
    private static void parseArgs(String[] args) {

        try {
            String arg;
            int i = 0;
            while (i < args.length) {
                arg = args[i++];
                if (arg.equals("-base")) {
                    if (i < args.length) {
                        arg = args[i++];
                        base_folder = arg;
                        System.out.println("base_folder: " + base_folder);
                    } else {
                        throw new Exception();
                    }
                } else if (arg.equals("-calc")) {
                    if (i < args.length) {
                        arg = args[i++];
                        calculus = arg;
                        System.out.println("calculus: " + calculus);
                    } else {
                        throw new Exception();
                    }
                } else if (arg.equals("-enc")) {
                    if (i < args.length) {
                        arg = args[i++];
                        encoding = arg;
                        System.out.println("encoding: " + encoding);
                        // No optimizations: ".GEN-0"
                        // Axiom R7 only: ".GEN-1"
                        // Axioms R6 and R7: ".GEN-2"
                        switch(encoding){
                            case "GEN-0":
                                axiom_R6 = false; 
                                axiom_R7 = false; 
                                break;
                            case "GEN-1":
                                axiom_R6 = false; 
                                axiom_R7 = true; 
                                break;
                            case "GEN-2":
                                axiom_R6 = true; 
                                axiom_R7 = true; 
                                break;    
                        }
                    } else {
                        throw new Exception();
                    }
                } 
            }
        } catch (Exception e) {
            System.err.println(
                    "Usage: RunExperiments\n"
                    + "\t[-base <path base data folder>]\n"
                    + "\t[-calc <calculus to be processed>]\n"
                    + "\t[-enc <applicable encoding>]\n");
            System.exit(0);
        }
    }

    /**
     * This function parses the specification file for the given calculus
     * loaded all relevant information about the calculus
     */
    private static void parseSpecifications() {
 
        try {
            String line;     
            File input_file = new File(base_folder + calculus + ".spec"); 
            BufferedReader br = new BufferedReader(new FileReader(input_file)); 
            while ((line = br.readLine()) != null) {
                line = line.trim();

                // Ignore empty or comment lines
                if(line.length() == 0 || line.startsWith("#")){
                    continue;
                }
                // Assign composition table file
                else if(line.startsWith("comp_table_file")){
                    comp_table_file = line.substring(16);
                    System.out.println("comp_table_file: " + comp_table_file);
                }
                // Assign converse file                
                else if(line.startsWith("converse_file")){
                    converse_file = line.substring(14);
                    System.out.println("converse_file: " + converse_file);
                }
                // Assign identity property
                else if(line.startsWith("identity")){
                    identity = line.substring(9).trim();
                    System.out.println("identity: " + identity);
                    if(identity.length() == 0){
                        throw new Exception();
                    }
                }
                else if(line.startsWith("calculus_size")){
                    calculus_size = new Integer(line.substring(14));
                    System.out.println("calculus size: " + calculus_size);
                    if (calculus_size < 1) {
                        throw new NumberFormatException();
                    }                    
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Check specification file format\n");
            System.exit(0);
        }
    }
        
    /**
     * This function prints the composition table and the base relations
     * for a given calculus
     * 
     * @param writer
     * @throws FileNotFoundException
     * @throws IOException 
     */
    private static void printCompositionTableAndBaseRelations(BufferedWriter writer) throws FileNotFoundException, IOException {
              
        String R1;
        String R2;
        String ROut;     
        Set<String> relationSet = new HashSet();

        ////////////////////////////////
        // Define "Composition Table" //
        ////////////////////////////////

        // Define composition table  
        File input_file = new File(base_folder + comp_table_file);         
        BufferedReader br = new BufferedReader(new FileReader(input_file)); 
        String line;
        while ((line = br.readLine()) != null) {
            line = line.trim();
            
            // Ignore empty or comment lines
            if(line.length() == 0 || line.startsWith("#")){
                continue;
            }
            
            // find the position of the composition operation symbol
            int compPos = line.indexOf(":");
            // find the position of the compusition operation result
            int resPos = line.indexOf("::");
            
            // Check if GQR syntax is followed
            if(compPos != -1 && resPos != -1){
                // Extract relations
                R1 = line.substring(0, compPos).trim();
                R2 = line.substring(compPos + 1, resPos).trim();
                ROut = line.substring(resPos + 2).trim();
                ROut = ROut.substring(ROut.indexOf("(") + 1, ROut.indexOf(")") - 1).trim();
                ROut = ROut.replaceAll(" ", ";");
                
                // Add possible relations to relations set
                relationSet.add(R1);
                relationSet.add(R2);
                
                writer.write("table(" + R1 + ", " + R2 + ", (" + ROut + ")).\n");                
                
            }
        }

        ////////////////////////////////////////
        // Define "Domain and Base Relations" //
        ////////////////////////////////////////

        // Define a unary predicate relation. Chck that the number of relations
        // corresponds to calculus size
        if(relationSet.size() == calculus_size){
            String relation = "relation(";
            for (String rel : relationSet) {
                relation += rel + "; ";
            }
            // remove semicolon from the last relation
            relation = relation.substring(0, relation.length()-2) + ").\n";
            writer.write(relation);
        }
    }

    /**
     * This function prints the converse relations for a given calculus
     * 
     * @param writer
     * @throws FileNotFoundException
     * @throws IOException 
     */
    private static void printConverseRelations(BufferedWriter writer) throws FileNotFoundException, IOException {
                
        /////////////////////////////////////////
        // Define "Antisymmetric optimisation" //
        ////////////////////////////////////////

        // Apply antisymmetric optimisation only if axiom R7 (Involution of converse)
        // is applicable for a given calculus
        if(!axiom_R7){
            return;
        }
        
        String R1;
        String R2;

        // Define composition table  
        File input_file = new File(base_folder + converse_file);         
        BufferedReader br = new BufferedReader(new FileReader(input_file)); 
        String line;
        while ((line = br.readLine()) != null) {
            line = line.trim();
            
            // Ignore empty or comment lines
            if(line.length() == 0 || line.startsWith("#")){
                continue;
            }
            
            // find the position of the converse operation symbol
            int convPos = line.indexOf("::");
            
            // Check if GQR syntax is followed
            if(convPos != -1){
                // Extract relations
                R1 = line.substring(0, convPos).trim();
                R2 = line.substring(convPos + 2).trim();
                
                // Generate rules only for pairs of different relations
                if(!R1.equals(R2)){
                    writer.write("true(Y," + R1 + ",X) :- true(X," + R2 + ",Y), X < Y.\n");
                }
            }
        }
    }
    
    public static void main(String[] args) throws Exception {

        parseArgs(args);        
        parseSpecifications();      

        // Define output file extension based on available optimizations
        String outputFile = base_folder + calculus + "/" + calculus + "-" + encoding + ".asp";
        
        // Generate ASP encoding
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(outputFile))) {                        
            
            ///////////////////////////
            // Define "Search Space" //
            ///////////////////////////
            
            // Define a ternary predicate true. Apply antisymmetric optimisation
            // based on axiom R7 (Involution of converse)
            writer.write("{true(X,R,Y) : relation(R)} = 1 :- element(X); element(Y); X" +
                    ((axiom_R7)? " < " : " != ") + "Y.\n");
            
            // Encode the case of constraints on a single element. Check if identity 
            // property has been defined
            if(identity.length() > 0){
                writer.write("true(X," + identity + ",X) :- element(X).\n");
            }   

            // Ensure that any relations that violate the composition table are excluded.
            // Add antisymmetric optimisation based on axiom R7 (Involution of converse)
            // and identity optimisation based on axiom R6 (Identity Law) where applicable
            writer.write(":- true(X,R1,Y); " + 
                    ((axiom_R7)? "X < Y; " : "") + 
                    "true(Y,R2,Z); " + 
                    ((axiom_R7)? "Y < Z; " : "") + 
                    (
                        (axiom_R6 && identity.length() > 0)? 
                        "R1!=" + identity + "; R2!=" + identity + "; " : ""
                    ) + 
                    "not true(X,Rout,Z) : table(R1,R2,Rout).\n");

            /////////////////////////////////////////
            // Define "Antisymmetric optimisation" //
            ////////////////////////////////////////

            // Ensure that the converse pair is also generated. Apply antisymmetric 
            // optimisation based on axiom R7 (Involution of converse)
            if(axiom_R7){
                printConverseRelations(writer);
            }
            
            ////////////////////////////////////
            // Define "Identity optimisation" //
            ////////////////////////////////////

            // Apply identity optimization based on axiom R6 (Identity Law) if identity 
            // relation is given. Note that if axiom R6 is applicable then for 
            // known qualitative calculus axiom R7 is applicable as well
            if(axiom_R6 && identity.length() > 0){
                writer.write(":- true(X," + identity + ",Y); true(Y,R,Z); not true(X,R,Z); Y < Z.\n");
                writer.write(":- true(X,R,Y); true(Y," + identity + ",Z); not true(X,R,Z); X < Y.\n");
            }

            ////////////////////////////////
            // Define "Input Constraints" //
            ////////////////////////////////

            // Enforse constraint predicates
            writer.write(":- constraint(X,_,Y); not true(X,R,Y) : constraint(X,R,Y).\n");
            
            ////////////////////////////////////////
            // Define "Domain and Base Relations" //
            // Define "Composition Table"         //
            ////////////////////////////////////////     
            
            // Print composition table and base relations
            printCompositionTableAndBaseRelations(writer);

        }
    }    
}

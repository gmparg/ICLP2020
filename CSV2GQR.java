/**
 * 
 */

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.ListIterator;
import java.io.BufferedWriter;
import java.io.FileWriter;

/**
 * @author George Baryannis
 * 
 * Generates input files in the format accepted by GQR using data from csvFile
 */
public class CSV2GQR {
	
	private static final String csvFile = "C:/los_angeles5g.csv";
	private static final String dlvFile = "C:/";
	private static final String cvsSplitBy = ",";
	private static final int size = 400;	
	
	/**
	 * @param args
	 */
	@SuppressWarnings("unused")
	public static void main(String[] args) {		
        BufferedReader br = null;
        BufferedWriter bw = null;
		FileWriter fw = null;
        String line = "";
        
        
        ArrayList<String> constraints = new ArrayList<String>();
        HashMap<Integer, Integer> regions = new HashMap<Integer, Integer>();
        
        try {
        	
        	br = new BufferedReader(new FileReader(csvFile));
        	int elem_count = -1;
        	br.readLine(); //skip header
        	while ((line = br.readLine()) != null) {
            	String[] cons = line.split(cvsSplitBy); 
            	
            	if(!regions.containsValue(Integer.valueOf(cons[0])) && !regions.containsValue(Integer.valueOf(cons[2]))){
            		constraints.add(" " + ++elem_count + " " + ++elem_count + " ( " + cons[1].toUpperCase()   + " )\n");
            		regions.put(elem_count-2, Integer.valueOf(cons[0]));
            		regions.put(elem_count-1, Integer.valueOf(cons[2]));
            		if(regions.size()>=size)
            			break;
            	}
            }
        	br.close();
        		
        	
	        	fw = new FileWriter(dlvFile + "RCC5-gqr-" + size + ".csp");
				bw = new BufferedWriter(fw);

	            
				bw.write(size-1 + " # RCC-5 with " + size + " regions\n");
	            
	            ListIterator<String> constIterator = constraints.listIterator();
	            while (constIterator.hasNext()) {
        			bw.write(constIterator.next());
	            }

	            bw.write(".\n\n");
            
	            bw.close();
	            fw.close();

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (bw != null)
				try {
					bw.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			if (fw != null)
				try {
					fw.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
        }

    }

}

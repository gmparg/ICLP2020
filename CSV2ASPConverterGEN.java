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
 * Generates GEN-0, GEN-1, GEN-2 and GEN-3 encodings using data from csvFile
 */
public class CSV2ASPConverterGEN {
	
	private static final String csvFile = "C:/los_angeles5g.csv";
	private static final String dlvFile = "C:/";
	private static final String calc = "RCC5-GEN";
	private static final String pyFile = "C:/script.py";
	private static final String cvsSplitBy = ",";
	private static final String pred_name = "traj";
	private static final String var_name = "";
	private static final int mode = 1; //0=full, including graph colouring; 1=qualitative only
	private static final int size = 300;	//number of regions
	private static final int version = 0;	//GEN-*
	
	
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
        	int elem_count = 0;
        	br.readLine(); //skip header
        	while ((line = br.readLine()) != null) {
            	String[] cons = line.split(cvsSplitBy); 
            	//System.out.println(Integer.getInteger(cons[0]) + " " + Integer.getInteger(cons[2]));
            	//System.out.println(regions.containsValue(Integer.valueOf(cons[0])) + " " + regions.containsValue(Integer.valueOf(cons[2])));
            	if(!regions.containsValue(Integer.valueOf(cons[0])) && !regions.containsValue(Integer.valueOf(cons[2]))){
            		constraints.add("constraint(" + ++elem_count + ", " + cons[1] + ", " + ++elem_count + ").\n");
            		regions.put(elem_count-2, Integer.valueOf(cons[0]));
            		regions.put(elem_count-1, Integer.valueOf(cons[2]));
            		if(regions.size()>=size)
            			break;
            	}
            }
        	br.close();
        	

        	for(int version=2; version<3; version++) {
        		
        	
	        	fw = new FileWriter(dlvFile + calc + "-" + version + "-" + size + ".asp");
				bw = new BufferedWriter(fw);
	            
	            
	            if(version==3) {
	            	BufferedReader br2 = new BufferedReader(new FileReader(pyFile));
	            	while ((line = br2.readLine()) != null) {
	            		bw.write(line + "\n");
	            	}
	            	br2.close();
	            }
	            
	            if(version==0) {
	            	bw.write("{true(X,R,Y) : relation(R)} = 1 :- element(X); element(Y); X != Y.\n");
	            }
	            else {
	            	bw.write("{true(X,R,Y) : relation(R)} = 1 :- element(X); element(Y); X < Y.\n");
	            }
	            bw.write("true(X,eq,X) :- element(X).\n");
	            if(version==0) {
	            	bw.write(":- true(X,R1,Y); true(Y,R2,Z); not true(X,Rout,Z) : table(R1,R2,Rout).\n");
	            }
	            else {
	            	if(version==3) {
	            		bw.write("true_conv(Y,ppc,X) :- true(X,pp,Y), X < Y.\n");
	            		bw.write("true_conv(Y,pp,X) :- true(X,ppc,Y), X < Y.\n");
	            	}
	            	else{
	            		bw.write("true(Y,ppc,X) :- true(X,pp,Y), X < Y.\n");
	            		bw.write("true(Y,pp,X) :- true(X,ppc,Y), X < Y.\n");
	            	}
	            	
	            	if(version==1) {
	            		bw.write(":- true(X,R1,Y); X < Y; true(Y,R2,Z); Y < Z; not true(X,Rout,Z) : table(R1,R2,Rout).\n");
	            	}
	            	else if(version==2) {
	            		bw.write(":- true(X,eq,Y); true(Y,R,Z); not true(X,R,Z); Y < Z.\n");
	            		bw.write(":- true(X,R,Y); true(Y,eq,Z); not true(X,R,Z); X < Y.\n");
	            		bw.write(":- true(X,R1,Y); X < Y; true(Y,R2,Z); Y < Z; R1!=eq; R2!=eq; not true(X,Rout,Z) : table(R1,R2,Rout).\n");
	            	}
	            }
	            
	            bw.write(":- constraint(X,_,Y); not true(X,R,Y) : constraint(X,R,Y).\n");
	            
	            bw.write("relation(eq; po; pp; ppc; dc).\n");
	            bw.write("table(eq, eq, (eq)).\n");
	            bw.write("table(eq, po, (po)).\n");
	            bw.write("table(eq, pp, (pp)).\n");
	            bw.write("table(eq, ppc, (ppc)).\n");
	            bw.write("table(eq, dc, (dc)).\n");
	            bw.write("table(po, eq, (po)).\n");
	            bw.write("table(po, po, (eq;po;pp;ppc;dc)).\n");
	            bw.write("table(po, pp, (po;pp)).\n");
	            bw.write("table(po, ppc, (dc;po;ppc)).\n");
	            bw.write("table(po, dc, (dc;po;ppc)).\n");
	            bw.write("table(pp, eq, (pp)).\n");
	            bw.write("table(pp, po, (dc;po;pp)).\n");
	            bw.write("table(pp, pp, (pp)).\n");
	            bw.write("table(pp, ppc, (eq;dc;po;pp;ppc)).\n");
	            bw.write("table(pp, dc, (dc)).\n");
	            bw.write("table(ppc, eq, (ppc)).\n");
	            bw.write("table(ppc, po, (po;ppc)).\n");
	            bw.write("table(ppc, pp, (eq;po;pp;ppc)).\n");
	            bw.write("table(ppc, ppc, (ppc)).\n");
	            bw.write("table(ppc, dc, (po;ppc;dc)).\n");
	            bw.write("table(dc, eq, (dc)).\n");
	            bw.write("table(dc, po, (dc;po;pp)).\n");
	            bw.write("table(dc, pp, (dc;po;pp)).\n");
	            bw.write("table(dc, ppc, (dc)).\n");
	            bw.write("table(dc, dc, (eq;po;pp;ppc;dc)).\n");
	            
	            ListIterator<String> constIterator = constraints.listIterator();
	            while (constIterator.hasNext()) {
        			bw.write(constIterator.next());
	            }
	            
	            String elem = "element(1";
	            for(int i=2;i<=elem_count;i++) {
	            	elem += "; " + i;
	            }
	            bw.write(elem + ").\n");
	            
	            //GRAPH COLOURING
	            if(mode==0) {
		            bw.write("color(red; green; blue).\n");
	
		            bw.write("{hasColor(X,C) : color(C)} = 1 :- element(X).\n");
	
		            bw.write(":- arc(V1, V2), hasColor(V1, X), hasColor(V2, Y), X=Y.\n");
		            bw.write("arc(V2, V1):- arc(V1, V2).\n");
		            bw.write("arc(V1, V2):-true(V1,eq,V2), V1!=V2.\n");
		            bw.write("arc(V1, V2):-true(V1,po,V2).\n");
		            bw.write("arc(V1, V2):-true(V1,pp,V2).\n");
		            bw.write("arc(V1, V2):-true(V1,ppc,V2).\n");
	            }
            
	            bw.close();
	            fw.close();
            }
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

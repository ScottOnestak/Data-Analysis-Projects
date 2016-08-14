import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

public class GetInfo {

	public static void main(String[] args) {
		
		//global variables
		String container;
		int schoolId,schoolNum;
		String[] holder;
		HashMap<Integer,Integer> mappings = new HashMap<Integer,Integer>();
		ArrayList<String> results = new ArrayList<String>();
		
		//hard-code of "elite" university category
		int[] topSchools = {1312,1710,9092,2178,1131,3242,3895,3024,2155,1305,1426,2626,2711,11693,2573,2029,1314,2803,3798,2894,1317,
				2903,6965,2233,6964,10366,1264,2882,1444,1535,1320,1313,3658,2785,2128,1564,3535,3604,2077,3401,1739,2520,2707,2920,
				1840,1445,3289,2133,3705,2978,2219,1328,2974,1140,6968,3378};

		try{
			//create buffered reader to read in HEGIS dataset to map the schoolID to the type of school
			BufferedReader br = new BufferedReader(new FileReader("02202-0001-Data.txt"));
			
			container = br.readLine();
			
			while(container != null){
				//the substring and school type identification number are provided by the codebook
				schoolId = Integer.parseInt(container.substring(1,6));
				schoolNum = Character.getNumericValue(container.charAt(26));
				if(!mappings.containsKey(schoolId)){
					mappings.put(schoolId, schoolNum);
				}
				
				container = br.readLine();
			}
			br.close();
		}catch(FileNotFoundException e){
			System.out.println("File not found: ");
		}catch(IOException e){
			e.printStackTrace();
		}
		
		//replace the "elite" school categories with their own category
		for(int i = 0; i < topSchools.length; i++){
			mappings.replace(topSchools[i], 0);
		}
		
		try{
			//read in the csv stata file to add the information
			BufferedReader reader = new BufferedReader(new FileReader("stataFile.csv"));
			
			container = reader.readLine();
			
			results.add(container + "," + "SCHOOLTYPE");
			
			container = reader.readLine();
			
			while(container != null){
				holder = container.split(",");
				schoolId = Integer.parseInt(holder[1]);
				results.add(container + "," + mappings.get(schoolId));
				
				container = reader.readLine();
			}
			reader.close();
		}catch(FileNotFoundException e){
			System.out.println("File not found: ");
		}catch(IOException e){
			e.printStackTrace();
		}
		
		try{
			//write this to a new file
			BufferedWriter bw = new BufferedWriter(new FileWriter("Results.csv"));
			
			for(int i = 0; i < results.size(); i++){
				bw.write(results.get(i) + "\n");
			}

			bw.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}

package RunnerPackage;

import com.intuit.karate.junit5.Karate;

public class testRunner {

	
	@Karate.Test
	public Karate runTest() {
		return Karate.run(".\\features").tags("smoke");	
	}

}

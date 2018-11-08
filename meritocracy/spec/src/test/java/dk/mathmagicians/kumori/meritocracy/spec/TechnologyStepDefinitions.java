package dk.mathmagicians.kumori.meritocracy.spec;

import static net.serenitybdd.rest.SerenityRest.when;

import cucumber.api.PendingException;
import cucumber.api.java.Before;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import io.restassured.RestAssured;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.rest.abiities.CallAnApi;
import net.thucydides.core.util.EnvironmentVariables;


public class TechnologyStepDefinitions {

	private String theRestApiBaseUrl;
	private EnvironmentVariables environmentVariables;
	private Actor jesper;
	private String apiUrl;
	private String jwt_token;

	@Before
	public void configureUrls() {

		// jesper = Actor.named("jesper/admin").whoCan(CallAnApi.at(apiUrl));
	}

	 @Given("^(\\w+) service is running$")
	    public void a_service_is_running(String serviceName) {
		// String serviceUrl = environmentVariables.getProperty(serviceName+".url");
		// RestAssured.baseURI = serviceUrl;
		// when().get("/")
		 //.then().statusCode(200);
	    }

	    @Given("^I have a valid security token$")
	    public void i_have_a_valid_security_token() {
	    	//fixme should use login instead when available
	        jwt_token = environmentVariables.getProperty("jwt_token");
	    }

	    @Given("^I edit technology with name \"([^\"]*)\"$")
	    public void i_edit_technology_with_name(String arg1) {
	        // Write code here that turns the phrase above into concrete actions
	        throw new PendingException();
	    }

	    @When("^I change the name to \"([^\"]*)\"$")
	    public void i_change_the_name_to(String arg1) {
	        // Write code here that turns the phrase above into concrete actions
	        throw new PendingException();
	    }

	    @Then("^I see that name is \"([^\"]*)\"$")
	    public void i_see_that_name_is(String arg1) {
	        // Write code here that turns the phrase above into concrete actions
	        throw new PendingException();
	    }

	    @When("^I navigate to edit page for a technology with name \"([^\"]*)\"$")
	    public void i_navigate_to_edit_page_for_a_technology_with_name(String arg1) {
	        // Write code here that turns the phrase above into concrete actions
	        throw new PendingException();
	    }

	    @Then("^the API returns a technology record with the name \"([^\"]*)\"$")
	    public void the_API_returns_a_technology_record_with_the_name(String arg1) {
	        // Write code here that turns the phrase above into concrete actions
	        throw new PendingException();
	    }

			@Given("^Jesper has a valid security token$")
public void jesper_has_a_valid_security_token() {
		// Write code here that turns the phrase above into concrete actions
		throw new PendingException();
}

@When("^Jesper wants to edit a technology with the name \"([^\"]*)\"$")
public void jesper_wants_to_edit_a_technology_with_the_name(String arg1) {
		// Write code here that turns the phrase above into concrete actions
		throw new PendingException();
}
}

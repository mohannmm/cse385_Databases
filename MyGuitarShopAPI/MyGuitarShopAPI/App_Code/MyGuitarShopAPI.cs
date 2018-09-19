using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Services;
using System.Security;

/// <summary>
///		Sample application to demonstrate a C# API
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class MyGuitarShopAPI : System.Web.Services.WebService {

	#region ######################################################################################################################################################## Notes
	    /*	Dynamic object Example ...
		    List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
		    Dictionary<string, object> row = new Dictionary<string, object>();
		    row.Add("Make", "G35");
		    row.Add("Model", "25 -18 Turbo");
		    row.Add("Year", 2014);
		    rows.Add(row);

		    row = new Dictionary<string, object>();
		    row.Add("Make", "Honda");
		    row.Add("Model", "Accord");
		    row.Add("Year", 2015);
		    rows.Add(row);

		    serialize(rows);
	    */
	#endregion

	#region ######################################################################################################################################################## Wrapper Methods [DON'T MODIFY]

		// Database
		private void addParam(string name, object value)						{	Helper.addParam(name, value);							}
		private DataSet sqlExecDataSet(string sql)								{	return Helper.sqlExecDataSet(sql);						}
		private DataTable sqlExecDataTable(string sql)							{	return Helper.sqlExecDataTable(sql);					}
		private DataTable sqlExec(string sql)									{	return Helper.sqlExec(sql);								}
		private DataTable sqlExec(string sql, DataTable dt, string udtblParam)	{	return Helper.sqlExec(sql, dt, udtblParam);				}
		private DataTable sqlExecQuery(string sql)								{	return Helper.sqlExecQuery(sql);						}

		// Serializer
		private void streamJson(string jsonString)								{	Helper.streamJson(jsonString);							}
		private void serialize(Object obj)										{	Helper.serialize(obj);									}
		private void serializeSingleDataTableRow(DataTable dt)					{	Helper.serializeSingleDataTableRow(dt);					}
		private void serializeDataTable(DataTable dt)							{	Helper.serializeDataTable(dt);							}
		private void serializeDataSet(DataSet ds)								{	Helper.serializeDataSet(ds);							}
		private void serializeXML<T>(T value)									{	Helper.serializeXML(value);								}
		private void serializeDictionary(Dictionary<object, object> dic)		{	Helper.serializeDictionary(dic);						}
		private void serializeObject(Object obj)								{	Helper.serializeObject(obj);							}

		// Going to leave this out so we don't need to import Newtonsoft.Json package
		//private T _download_serialized_json_data<T>(string url) where T : new()	{	return Helper._download_serialized_json_data<T>(url);	}

	#endregion


	//=== Web Service Methods Follow Below
    [WebMethod(Description = "Local creation of a query to database.")]
    public void getCustomersByFilter(int count, string filter) {

		/*
		 *
			Note: You may need to add this Stored Procedure to SQL Server:

			-----------------------------------------------------------------------------------------------------------------------------

			CREATE PROCEDURE [dbo].[spGetCustomersByFilter]
				@filter varchar(50),
				@count int
			AS

				if(@count = 0) SELECT @count = COUNT(*) FROM Customers
				SELECT TOP(@count) * FROM Customers WHERE (EmailAddress + '_' + FirstName + '_' + LastName) LIKE '%' + @filter + '%'
		
			-----------------------------------------------------------------------------------------------------------------------------

 		*
		*/



		/*	Version 1: Not a good method. Try entering in:  ' OR 1=1 --  as the email*/
		// serializeDataTable(sqlExecQuery("SELECT * FROM Customers WHERE (EmailAddress + '_' + FirstName + '_' + LastName) LIKE '%" + filter  + "'"));

		/*	Version 2: Much better means of security	*/
		filter = filter.Trim();
		addParam("@filter", filter);
		addParam("@count", count);
        serializeDataTable(sqlExec("spGetCustomersByFilter"));
    }


	[WebMethod(Description = "TEST API CALL FOR JQUERY CONSUMPTION - max retun count = 30, filter by make, model or year.  Set count=0 and filter = \"\" for random cars<br /><br />possible makes: Honda, Toyota, BMW, Ford<br />possible models: Truck, Sport, Hatchback, Coupe, Sedan, SU, MiniVan<br />possible years: 2000-2018")]
	public void Cars(int count, string filter) {
		List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
		Dictionary<string, object> row;

		// Set up random cars and add them to the list to return to user. If a filter is added
		// just add cars that fit into the filter
		string[] makes = { "Honda", "Toyota", "BMW", "Ford" };
		string[] models = { "Truck", "Sport", "Hatchback", "Coupe", "Sedan", "SUV", "MiniVan" };
		Random rnd = new Random();
		int attempt = 0;
		int maxRows = 30;
		int num = (count <= 0 ? maxRows : Math.Min(count, maxRows));
		filter = filter.Trim();
		while (true) {
			row = new Dictionary<string, object>();
			row.Add("Make", makes[rnd.Next(makes.Length)]);
			row.Add("Model", models[rnd.Next(models.Length)]);
			row.Add("Year", rnd.Next(19) + 2000);

			// Note: The code line: String.Join("-",row) would produce a string that looks like:
			//
			//		[Make, Honda]-[Model, SUV]-[Year, 2010]

			if (filter.Length == 0 ||  String.Join("-",row).ToLower().Contains(" " + filter.ToLower() + "]")) { 
				rows.Add(row);
			}
			if (rows.Count == num || ++attempt > 1000) break;
		}

		serialize(rows);
	}


    [WebMethod(Description = "method using class objects")]
    public void getOwnersAndCars()
    { List<Owner> owners = new List<Owner>();

        Owner o = new Owner("tom", "ryan");
        o.cars.Add(new Car("Ford", "Taurus", 2000));
        o.cars.Add(new Car("Ford", "Focus", 2001));
        o.cars.Add(new Car("Honda", "Pilot", 2002));
        o.cars.Add(new Car("Ford", "F150", 2003));
        owners.Add(o);

        o = new Owner("John", "joe");
        o.cars.Add(new Car("Ford", "Taurus", 2000));
        o.cars.Add(new Car("Ford", "Focus", 2001));
        o.cars.Add(new Car("Honda", "Pilot", 2002));
        o.cars.Add(new Car("Ford", "F150", 2003));
        owners.Add(o);


        serialize(owners);
        //=====================Inner Class
    }
    private class Owner
    {
        public string fn, ln;
        public List<Car> cars;
        public Owner(string fn, string ln)
        {
            this.fn = fn;
            this.ln = ln;
            cars = new List<Car>();
        }
    }

    private class Car
    {
        public string make, model;
        public int year;
        public Car(string make, string model, int year)
        {
            this.make = make;
            this.model = model;
            this.year = year;
        }
    }
    }

/*
var client = new Twitter({
    consumer_key: "",
    consumer_secret: "",
    access_token_key: "",
    access_token_secret: ""
});
*/

class TwitterApi
{
    const string TwitterApiBaseUrl = "https://api.twitter.com/1.1/";
    readonly string consumerKey, consumerKeySecret, accessToken, accessTokenSecret;
    readonly HMACSHA1 sigHasher;
    readonly DateTime epochUtc = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);

    /// <summary>
    /// Creates an object for sending tweets to Twitter using Single-user OAuth.
    /// 
    /// Get your access keys by creating an app at apps.twitter.com then visiting the
    /// "Keys and Access Tokens" section for your app. They can be found under the
    /// "Your Access Token" heading.
    /// </summary>
    public TwitterApi(string consumerKey, string consumerKeySecret, string accessToken, string accessTokenSecret)
    {
        this.consumerKey = consumerKey;
        this.consumerKeySecret = consumerKeySecret;
        this.accessToken = accessToken;
        this.accessTokenSecret = accessTokenSecret;

        sigHasher = new HMACSHA1(new ASCIIEncoding().GetBytes(string.Format("{0}&{1}", consumerKeySecret, accessTokenSecret)));
    }

    /// <summary>
    /// Sends a tweet with the supplied text and returns the response from the Twitter API.
    /// </summary>
    public Task<string> Tweet(string text)
    {
        var data = new Dictionary<string, string> {
            { "status", text },
            { "trim_user", "1" }
        };

        return SendRequest("statuses/update.json", data);
    }

    Task<string> SendRequest(string url, Dictionary<string, string> data)
    {
        var fullUrl = TwitterApiBaseUrl + url;

        // Timestamps are in seconds since 1/1/1970.
        var timestamp = (int)((DateTime.UtcNow - epochUtc).TotalSeconds);

        // Add all the OAuth headers we'll need to use when constructing the hash.
        data.Add("oauth_consumer_key", consumerKey);
        data.Add("oauth_signature_method", "HMAC-SHA1");
        data.Add("oauth_timestamp", timestamp.ToString());
        data.Add("oauth_nonce", "a"); // Required, but Twitter doesn't appear to use it, so "a" will do.
        data.Add("oauth_token", accessToken);
        data.Add("oauth_version", "1.0");

        // Generate the OAuth signature and add it to our payload.
        data.Add("oauth_signature", GenerateSignature(fullUrl, data));

        // Build the OAuth HTTP Header from the data.
        string oAuthHeader = GenerateOAuthHeader(data);

        // Build the form data (exclude OAuth stuff that's already in the header).
        var formData = new FormUrlEncodedContent(data.Where(kvp => !kvp.Key.StartsWith("oauth_")));

        return SendRequest(fullUrl, oAuthHeader, formData);
    }

    /// <summary>
    /// Generate an OAuth signature from OAuth header values.
    /// </summary>
    string GenerateSignature(string url, Dictionary<string, string> data)
    {
        var sigString = string.Join(
            "&",
            data
                .Union(data)
                .Select(kvp => string.Format("{0}={1}", Uri.EscapeDataString(kvp.Key), Uri.EscapeDataString(kvp.Value)))
                .OrderBy(s => s)
        );

        var fullSigData = string.Format(
            "{0}&{1}&{2}",
            "POST",
            Uri.EscapeDataString(url),
            Uri.EscapeDataString(sigString.ToString())
        );

        return Convert.ToBase64String(sigHasher.ComputeHash(new ASCIIEncoding().GetBytes(fullSigData.ToString())));
    }

    /// <summary>
    /// Generate the raw OAuth HTML header from the values (including signature).
    /// </summary>
    string GenerateOAuthHeader(Dictionary<string, string> data)
    {
        return "OAuth " + string.Join(
            ", ",
            data
                .Where(kvp => kvp.Key.StartsWith("oauth_"))
                .Select(kvp => string.Format("{0}=\"{1}\"", Uri.EscapeDataString(kvp.Key), Uri.EscapeDataString(kvp.Value)))
                .OrderBy(s => s)
        );
    }

    /// <summary>
    /// Send HTTP Request and return the response.
    /// </summary>
    async Task<string> SendRequest(string fullUrl, string oAuthHeader, FormUrlEncodedContent formData)
    {
        using (var http = new HttpClient())
        {
            http.DefaultRequestHeaders.Add("Authorization", oAuthHeader);

            var httpResp = await http.PostAsync(fullUrl, formData);
            var respBody = await httpResp.Content.ReadAsStringAsync();

            return respBody;
        }
    }
}

ZOMATO RESTAURANTS APP

## IMPLEMENTATION

DEPENDENCIES:  This app used the zomato API (https://developers.zomato.com) to fetch list of restaurants of various kinds as provided by Zomato.

SOFTWARE REQUIREMENTS: Xcode 12, Swift 5

MAIN DETAILS:

The main entry of the app is a Tab Bar Controller. This holds two Navigation Controller which are responsible for the overall flow and logic of the app.

The first Navigation Controller has the Collection Table View Controller as its' root view controller. The Collection Table View Controller Shows all the collections as fetched from the Zomato API api using the (https://developers.zomato.com/api/v2.1/collections) endpoint. Each Table View Cell in the Collection Table View Controller are responsible for displaying a specific collection. If each of the table view cell is clicked it navigates to the Collection Restaurants Table View Controller. 

The Collection Restaurants Table View Controller is responsible for displaying all restaurants that belongs to a specific collection which are fetched from this endpoint (https://developers.zomato.com/api/v2.1/search?collection_id={collectionId}). It's table cell shows each of this restaurants and if any of the table cell is clicked it navigates the user to the Restaurant View Controller.

The Restaurant View Controller is responsible for showing more details about a specific restaurant. It also uses core data to save the restaurant data.

The second Navigation Controller has the Category Table View Controller as its' root view controller. The Category Table View Controller shows all the categories as fetched from the Zomato API using the endpoint (https://developers.zomato.com/api/v2.1/categories). Each Table View Cell in the Category Table View are responsible for displaying each category text. Also, the Category Table View Controller has a right bar button called (SAVES) which when clicked navigate the user to seeing all saved restaurants from Core Data. When each of the Category Table View Cell are clicked it navigates to Category Restaurants Table View Controller which is responsible for showing all the restaurants that belongs to this category.

The Category Restaurants Table View Controller implementation is similar to the Collection Restaurants Table View Controller. The main difference is in the type of data they fetch. On clicking the Category Restaurants Table Cell it navigates to the Restaurants View Controller which is responsible for showing more details about a specific restaurant.

FRAMEWORK: 
	Core Data
		Used to save restaurant for later access. This is setup in the AppDelegate and then used in the Restaurant View Controller and the Category Restaurant View Controller to both save and fetch data respectively.

	2. Map Kit
		Used to show the location of a restaurant. This is used in the Restaurant View Controller to display the location of a restaurant on a map



## LICENSE

Copyright (c) 2020 Babatunde Ololade

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.




# Bingeflix iOS App

Bingeflix iOS mobile app developed using MVVM design pattern.

Here is a video of the app in action : 

## Tech Specs:
#### Frontend Specifications
* SwiftUI2
* Libraries: Alamofire, SwiftyJSON

#### Backend Specifications
* Node.js v14.16.0
* Express.js (@4.17.1)

## Views 

### Home  

> The starting view showing a list of currently highest rated, trending and popular Movies and TV shows.

#### Features:
* Toggle between Movies and TV shows
* Rotating Carousel of the latest movies/tv shows
* Context menu (Force touch/Long press) with options for sharing and adding media to watchlist

#### Screens:
<img width="443" alt="Movies_home" src="https://user-images.githubusercontent.com/60423353/119455136-28579980-bcee-11eb-9d8d-a6dc61dd870a.png"><img width="446" alt="context_menu2" src="https://user-images.githubusercontent.com/60423353/119455218-3dccc380-bcee-11eb-8ec5-73311072bfe1.png">

<img width="445" alt="TV_home" src="https://user-images.githubusercontent.com/60423353/119455188-360d1f00-bcee-11eb-808d-bb13d5a5d8cb.png"><img width="440" alt="Context_menu" src="https://user-images.githubusercontent.com/60423353/119455235-40c7b400-bcee-11eb-895f-94176505f3e2.png">

---

### Media Detail

> Details for the selected media (Movie or TV show) that displays the following:
> * Embedded Trailer/Teaser Video (from youtube) 
> * Original Airdate, Average rating, Genre & languages
> * Description of the plot (collapsible)
> * Share buttons (facebook and twitter open in safari)
> * Cast and Crew Cards
> * Reviews (option to view content in full)
> * Recommended Media

#### Screens:
<img width="437" alt="details_top" src="https://user-images.githubusercontent.com/60423353/119455593-99974c80-bcee-11eb-8784-a9d487246128.png"><img width="440" alt="details_mid" src="https://user-images.githubusercontent.com/60423353/119455623-9f8d2d80-bcee-11eb-9225-2bebac3ec50b.png">
<img width="437" alt="details_bottom" src="https://user-images.githubusercontent.com/60423353/119455633-a1ef8780-bcee-11eb-9a6b-3f18148f3067.png"><img width="439" alt="reviews_detail" src="https://user-images.githubusercontent.com/60423353/119455766-c5b2cd80-bcee-11eb-8a01-fca101a67b1b.png">


#### Share (opens in safari)

<img width="440" alt="facebook" src="https://user-images.githubusercontent.com/60423353/119455843-de22e800-bcee-11eb-9503-a58262e3c85c.png"><img width="439" alt="twitter" src="https://user-images.githubusercontent.com/60423353/119455927-f5fa6c00-bcee-11eb-8ac8-0bc64ca5c1e7.png">

---

### Watchlist

> User list containing all saved media implemented using UserDefaults interface
> Ability to remove media from watchlist on long press using context menu
> Change order of media using drag and drop functionality


#### Screens:

<img width="440" alt="watchlist" src="https://user-images.githubusercontent.com/60423353/119455939-fb57b680-bcee-11eb-8d80-6db99c7518d9.png">

---

### Search:

> Search with debouncing for string of length 3 or more 
> Displays results as cards with backdrop image, media type, rating and release date

#### Screens:

<img width="440" alt="search" src="https://user-images.githubusercontent.com/60423353/119455783-ca778180-bcee-11eb-8234-82d65cb0de24.png">






# Vehicle

## AppDelegate

- In Appdelegate i have just checked the path of squilte DB for checking whether data stored in table or not.

## Coredata

Three table has been created List, Details and it's locations. 
I have created Generic persistance for performing crud operaions, so it will be easy to use whenever we are storing large amout of API response data and we don't want to create separate database model, using this files we will just pass our API model and will get the same model in fetch query.

 ## Repository
    
   This class having protocol functions related to CRUD operations, fetch the details i.e stored in table also added storable type means it will perform all operations directly to API model and return the same API model that we have passed. So, We don't have to create new model for database.
        
  ## DBManager
    
   This class implement all the functions of Repository, As it binds repository object, storable type and entity type. 
   This class having insertion, deletions and fetch query. 
      
   One main thing is it checks whether this object is already stored in table or not if it's already stored then it return stored object, so we can update that object while insertion. 
      
   ## CoreDataService
      
  This class conatins persistence container and view context.
        
  -> Core Data Classes and Database Model having actually implementations of insertions and fetch query. 
    
   Also i have added one to one relation to follwoing cases.
     
   Vehicle List  TO Vehicle Details
    Vehicle List TO Location.
      
## Project Log, Extensions and Image Loader

 --> In Project i have used print statement in debug mode, also i have added from where that print statement called, (Function name, Path and Line number), also it print whether thread is main or background. 
 
 --> In extensions class, i have added extension for image (resize annotations), round corner (Bottom sheet) and Table view (for register cell, it also check whether cell is created via xib or through storyboard )
 
 --> In image loader, i have added NSCache for caching image with key and value,  it download image from server and cache that image using specified key.

## Network Layer

   ----> Added Environment class where we can store staging, productions api base path, So just we have to change enum value staging to production and vice versa whenever required.
   
   --> Added Router Class for API wise Path, their methods and parameter,  in this project i have added only path as it's GET APi, no parameter is there. But we can extend this class for all API needs.

## Annotation

---> I have created custom mkpoint annotation class where we can add multiple properties to annotations so whenever there is an requirement to check all the details of particular annotation then we can check using this.

## Web Services

---> i have created singelton class for getting vehicle listing, used url session data task method for fetching all the details. 

--> In getvehicle detail function i have used two block completions and error block with escaping sequence, here escaping sequence is used because the result or error come in few second depends upon the server request. So whenever there is a waiting period of any parameter (error, response) then in that case escaping sequence is used. 

## Map List View Model

--> in this class, i have created properties and closure for sending updates to controller, in view model network API is being called and DB operations is performed.

--> Also API will be called only in case when there isn't any DB result. 

## Model (Vehicle List)

-->> Used Decodable struct for storing API response, here i haven't used codable type because we don't have to send these data to server. 

## MapViewController

--> This is the main controller where map and listing is being shown, for map i haved mapkit.

This controller having view model object so it can access API data from view model. As in View model all udates is being passed through closure. 


Attached Screen Shot

1. https://prnt.sc/12h1iog
2. https://prnt.sc/12h1k7a


Here is the video of demo

https://drive.google.com/file/d/1zMXe45CLjC44NrBqeYD01U4Tu3otw5YM/view?usp=sharing

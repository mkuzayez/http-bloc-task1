# Separation of Concerns in Flutter:

Multi-layered architecture is a good practice when working with Flutter, 
especially when implementing clean code principles like separation of concerns.

[Network Layer] Data Provider: is responsible for external data access, like making network calls to get data from an API.
Use "request" to indicate pulling data from an external source.


[Repository Layer] DataRepo: is responsible for transforming and handling the data (i.e., converting the raw JSON to model objects).
Use "retrieve" to indicate transforming or modeling the data for internal use.


[Cubit/BLoC Layer] DataCubit/BLoC: manages the application's state and triggers UI updates.
Use "load" to indicate managing the app state with this data.

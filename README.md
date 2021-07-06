# Shop Manager

An Instagram-based clothing shop mobile application manager developed using Flutter.
Project is under development.

## Overview
  
Application communicates with Google Firebase synchronizing through Google Cloud to a Google Sheet.
The Sheet is split into three Worksheets upon which CRUD operations are implemented:
    - Pending orders,
    - Archived orders,
    - Deleted orders.

Loading screen:
  - [X] shown while connecting to Firebase and Google Cloud. 
  
Dashboard: 
  - [X] all pending orders are shown in a separated ListView;
  - [ ] each order shows client's Instagram profile picture (awaiting Instagram API full release),
  - [X]                             username, 
  - [X]                             order status (PENDING/SENT/ARRIVED),
  - [X]                             time since placed (x minute(s) ago / y hours ago / last month / etc.),
  - [X]                             order price value.
  - [X] each order is a Dismissable widget.
  - [X] swiped from Start to End the order gets Archived; 
  - [X] swiped from End to Start the order gets Deleted;
  - [X] bottom navigation bar switches between Orders View and Business Statistics;
  - [X] top appBar shows brand logo and two buttons: 
            - Archive viewer;
            - Create new order;
  - [X] Archived orders view; 
  
Order Add Page:
  - [X] Form with validation receiving the required attributes of a new order;
  - [X] Upon completion, the page pops sliding back to the Dashboard refreshing the list of orders with the latest added on top;

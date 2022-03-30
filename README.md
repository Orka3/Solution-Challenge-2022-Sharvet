# 🥬Sharvet Project
### - Vegetables you share will save the Earth.
### - Team MEG
[Songgyeong Oh](https://github.com/Orka3/), [Moon]

<p align="center">
  <img width="30%" alt="sharvet" src="https://user-images.githubusercontent.com/100416968/160620865-ce075998-5a70-4cd1-8720-6e1bf38e1faa.PNG">
</p>

## 📢How to Install?

## 💡Outline
### 1) Project Outline
Sharvet is the app that contributes to reducing carbon footprints by exchanging food waste into sustainable resources.
### 2) Background of topic selection
When we say the word ‘food waste’, in our minds, we probably think some rotten apples and carrots.

But what we actually find in trash bins are absolutely perfect apples and carrots.

We produce four billion tons of food a year. One-third of them are thrown away before they reach the dining table.

Many foods that can be eaten are thrown away in markets just because they are little damaged.

Every year, A larger area of land than China and 250(two hundred fifty) trillion liters of water are used to produce 1 billion tons of food to be discarded.

Eventually, resources for food to be discarded are depleted, greenhouse gasses are emitted, and the Earth is heating up.

### 3) Primary User
```
1. Giver
- Giver shares food waste with farmers.
- Giver is mainly a place where a lot of food waste comes from, such as markets and restaurants.
- They originally had to pay a lot of money to dispose of food waste.
- If they use 'Sharvet', they can reduce the cost of disposal food waste by sharing the crops to farmer.

2. Farmer
- Farmer receives food waste for free and feeds them to their animals.
- If they use 'Sharvet', they can reduce the feed cost.

```
## 💡Application Design
### 1) Use Stacks
```
- Flutter
- Firebase (Firebase FireStore, Authentication)
- Open api (Livestock Information)
```
### 2) Copyright
```
- Icon
Copyright © 2010-2022 Freepik Company S.L.
```
## 💡Detail Function
### Intention of the plan.
#### 1. Sign up & Sign in
<p align="middle">
  <img src="https://user-images.githubusercontent.com/100416968/160740394-d3a26eb0-7572-4c3a-bd65-c6fce18fbafd.png" width="200" height="370">
  <img width="200" height="370" alt="sharvet" src="https://user-images.githubusercontent.com/100416968/160740403-30ce3279-9729-4ab7-9ab5-7984144d0202.png">
  <img width="200" height="370" alt="sharvet" src="https://user-images.githubusercontent.com/100416968/160740408-5b4e4d86-07a5-49ba-82e7-9463e81b88ce.png">
</p>  
Sharvet has to log in to start, and user have to choose the job between farmer and giver.
We used Firebase authentication to implement function.

#### 2. Giver- Posting the Reservation
<p align="middle">
    <img width="200" height="370" alt="sharvet" src="https://user-images.githubusercontent.com/100416968/160740504-eafe45f2-7d31-4775-82f1-914d0a3cff10.png">
    <img width="200" height="370" alt="sharvet" src="https://user-images.githubusercontent.com/100416968/160740516-9dbc2f45-831e-4486-beb6-2aa723d87a53.png">
    <img width="200" height="370" alt="sharvet" src="https://user-images.githubusercontent.com/100416968/160740525-4383cd74-53e2-42c3-87e7-15c0a453e621.png">
    <img width="200" height="370" alt="sharvet" src="https://user-images.githubusercontent.com/100416968/160740543-dcfb9ff3-5541-4c8c-b7c6-b97c80f5c190.png">
</p>
For the connection between farmer and giver, giver has to post the reservation.
In the posting, basic information about giver, the date that giver can give vegetables, amount and sort of the vegetables, possible delivery area and p.s. should be written.

#### 3. Farmer- Make a Reservation
<p align="middle">
   <img width="200" height="370" alt="sharvet" src="https://user-images.githubusercontent.com/100416968/160740741-6fbce868-63b6-4565-b504-2383331e3170.png">
 <img width="200" height="370" alt="sharvet" src="https://user-images.githubusercontent.com/100416968/160740753-2d791bdb-060a-4fcb-9233-8677ee08b9b6.png">
 <img width="200" height="370" alt="sharvet" src="https://user-images.githubusercontent.com/100416968/160740764-83258c3c-61bb-4fc9-a467-51bf068cc5c4.png">
</p>
Farmer can see the giver's posting lists, and the detail of them.
Farmer should click the button to complete the reservation.

#### 4. Farmer, Giver- Tracking Information
<p align="middle">
   <img width="200" height="370" alt="sharvet" src="https://user-images.githubusercontent.com/100416968/160740780-ad4dbde3-d0fa-49fb-a87d-1859084754ac.png">
</p>
Farmer and Giver can see their reservation in the tracking information tab.
There are basic information of reservation and reservation state.

#### 5. Giver - Change the Reservation State
<p align="middle">
 <img width="200" height="330" alt="sharvet" src="https://user-images.githubusercontent.com/100416968/160740602-70a52864-caae-4299-a269-ba6e0ea89036.png">
</p>
Giver should change the reserevation state according to the delivery process. 
There are 'Checked, In transit, Delivered' states.
The reservation state will be sended to farmer.

#### 6. Farmer - Get Livestock Information
<p align="middle">
 <img width="200" height="330" alt="sharvet" src="https://user-images.githubusercontent.com/100416968/160740789-18d7f37e-be98-45ec-87eb-a16f19838aca.png">
</p>
The Information necessary for ranch management is provided to Farmer, using the Open api provided by the Korea Livestock Science Institute.
For example, real-time livestock heat index forecast and real-time livestock price will be provided.

#### 7. Giver - Benefit of using Sharvet
<p align="middle">
 <img width="200" height="330" alt="sharvet" src="https://user-images.githubusercontent.com/100416968/160740641-72b71a2b-9261-4abf-a943-c4e065ca76eb.png">
</p>
In rank tab, giver can see their own ranks and benefits.
Each time a reservation is completely delivered, the mileage increases
The rank is determined according to the accumulated mileage.
The benefits are different for each rank.

#### 8. Farmer, Giver - Profile tab
<p align="middle">
  <img width="200" height="370" alt="sharvet" src="https://user-images.githubusercontent.com/100416968/160740696-3529efdf-03e2-47d8-86a3-cb90eb387531.png">
  <img width="200" height="370" alt="sharvet" src="https://user-images.githubusercontent.com/100416968/160740801-634fb5cf-2c3e-4a8c-9a51-f807d4be500e.png">
</p>
User can see and edit their own profile.
They can also view the completed history.

### Bugs and fixes
#### 1.Open api not implemented due to ongoing qualification review at the Livestock Science Center.
#### 2.Some UI bugs.

## 💡Direction of Expansion & Expectation Effectiveness
### 1) Direction of Expansion
```
1. Implementation of consumer-side apps
Implementation of consumer-side apps for customer who used giver’s and farmer’s business. 
They can see the ranking and transactions of giver and farmer that contribute to the environment.
This encourages companies to donate harder for publicity. 
At the same time, encouraging consumers to pay attention to the environment.
2. Formation of partnership 
MOU with Ministry of Environment or hypermarket to ensure popularity.
```
### 2) Expectation Effectiveness
```
1. Reduce environmental pollution caused by food waste.
2. Providing educational opportunities and Improving ranch management skills,
By making easier for elderly farmers, who are digitally marginalized, to access livestock information.
3. Encouraging farmers, companies, consumers to pay attention to the environment.
```
### Expanding into applications that contribute to reducing greenhouse gas emissions by exchanging food waste into sustainable resources in cooperation with farmers and businesses

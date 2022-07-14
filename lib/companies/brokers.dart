

class InsuranceBroker{
  final String title;
  final String subtitle;
  //final int price;
  //final String loyaltyPoints;
  final String rating;
  //final int iScore;
  final int index;
  final String image;
  //final String limits;
  //final bool atFirst;
  bool selected;
  final List<String> insuranceOptions;

  InsuranceBroker(
      {
        required this.title,
        required this.rating,
        required this.subtitle,
      //  required this.limits,
       // required this.atFirst,
        //required this.price,
      //  required this.loyaltyPoints,
       // required this.iScore,
        required this.index,
        required this.image,
        this.selected = false,
        required this.insuranceOptions,
      });
}

List<InsuranceBroker> insuranceBrokers = [

  InsuranceBroker(
    title: "Deraya Insurance Brokerage",
    index: 0,
    rating: '9/10',
    image: "assets/deraya.png",
    subtitle: "",
    insuranceOptions : [
      "Rent a car",
      "Road assistance",
      "Driver's personal accident coverage",
      "Coverage for drivers under 21 years old",
    ],
  ),
  InsuranceBroker(
    title: "BMW Egypt Insurance",
    index: 1,
    rating: '9/10',

    image: "assets/bmw.jpg",
    subtitle: "",
    insuranceOptions : [
      "Rent a car",
      "Road assistance",
      "Driver's personal accident coverage",
      "Coverage for drivers under 21 years old",
    ],
  ),
  InsuranceBroker(
    title: "Future Insurance Brokerage",
    index: 2,
    rating: '8/10',

    image: "assets/future insurance.PNG",
    subtitle: "",
    insuranceOptions : [
      "Rent a car",
      "Road assistance",
      "Driver's personal accident coverage",
      "Coverage for drivers under 21 years old",
    ],
  ),
  InsuranceBroker(
    title: "GoodLife Insurance Brokers",
    index: 3,
    rating: '9/10',
    image: "assets/goodlife.png",
    subtitle: "",
    insuranceOptions : [
      "Rent a car",
      "Road assistance",
      "Driver's personal accident coverage",
      "Coverage for drivers under 21 years old",
    ],
  ),
  InsuranceBroker(
    title: "GIG Insurance Brokers",
    index: 4,
    rating: '7/10',

    image: "assets/gig.png",
    subtitle: "",
    insuranceOptions : [
      "Rent a car",
      "Road assistance",
      "Driver's personal accident coverage",
      "Coverage for drivers under 21 years old",
    ],
  ),


];
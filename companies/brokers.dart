

class InsuranceBroker{
  final String title;
  final String subtitle;
  //final int price;
  //final String loyaltyPoints;
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
    image: "assets/deraya.png",
    subtitle: "",
    insuranceOptions : [
      "استئجار سياره",
      "المساعده علي الطريق",
      "تخطيه الحوادث الشخصيه للسائق",
      "تغطيه السائقين الاقل من 21 سنه",
      "تغطيه دول مجلس التعاون الخليجي",
    ],
  ),
  InsuranceBroker(
    title: "BMW Egypt Insurance",
    index: 1,
    image: "assets/bmw.jpg",
    subtitle: "",
    insuranceOptions : [
      "استئجار سياره",
      "المساعده علي الطريق",
      "تخطيه الحوادث الشخصيه للسائق",
      "تغطيه السائقين الاقل من 21 سنه",
      "تغطيه دول مجلس التعاون الخليجي",
    ],
  ),
  InsuranceBroker(
    title: "Future Insurance Brokerage",
    index: 2,
    image: "assets/future insurance.PNG",
    subtitle: "",
    insuranceOptions : [
      "استئجار سياره",
      "المساعده علي الطريق",
      "تخطيه الحوادث الشخصيه للسائق",
      "تغطيه السائقين الاقل من 21 سنه",
      "تغطيه دول مجلس التعاون الخليجي",
    ],
  ),
  InsuranceBroker(
    title: "GoodLife Insurance Brokers",
    index: 3,
    image: "assets/goodlife.png",
    subtitle: "",
    insuranceOptions : [
      "استئجار سياره",
      "المساعده علي الطريق",
      "تخطيه الحوادث الشخصيه للسائق",
      "تغطيه السائقين الاقل من 21 سنه",
      "تغطيه دول مجلس التعاون الخليجي",
    ],
  ),
  InsuranceBroker(
    title: "GIG Insurance Brokers",
    index: 4,
    image: "assets/gig.png",
    subtitle: "",
    insuranceOptions : [
      "استئجار سياره",
      "المساعده علي الطريق",
      "تخطيه الحوادث الشخصيه للسائق",
      "تغطيه السائقين الاقل من 21 سنه",
      "تغطيه دول مجلس التعاون الخليجي",
    ],
  ),


];
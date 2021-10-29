import 'package:cart/CartPageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

bool viewCart = false;
List<dynamic> data = [];
List<dynamic> list = [];

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 5),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 20)),
            cartListview(),
            Padding(padding: EdgeInsets.only(top: 10)),
            viewMore(),
            cartitemsListview()
          ],
        ),
      ),
    );
  }

  Widget cartListview() {
    return Selector<CartPageController, List<dynamic>>(
        shouldRebuild: (a, b) => true,
        selector: (buildContext, cartPageController) => cartPageController.data,
        builder: (context, datas, child) {
          data = datas;
          return ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return cartCard(index);
              });
        });
  }

  Widget cartitemsListview() {
    return Selector<CartPageController, List<dynamic>>(
        shouldRebuild: (a, b) => true,
        selector: (buildContext, cartPageController) => cartPageController.list,
        builder: (context, datas, child) {
          list = datas;
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: list.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return cartListSelected(index);
              });
        });
  }

  Widget cartCard(int index) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 3,
        color: Colors.blue[50],
        child: Column(
          children: <Widget>[
            cartRow(index),
            Padding(padding: EdgeInsets.only(top: 8)),
            cartDescription(index),
            Padding(padding: EdgeInsets.only(top: 8)),
            cartIncreDecre(index),
          ],
        ),
      ),
    );
  }

  Widget cartTitle(int index) {
    return Row(
      children: [
        Text(
          data[index]["Title"],
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ],
    );
  }

  Widget cartDescription(index) {
    return Row(
      children: [
        Text(
          data[index]["description"],
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 18),
        ),
      ],
    );
  }

  Widget cartRow(int index) {
    return Row(
      children: [
        cartTitle(index),
        Spacer(),
        cartQuantity(index),
        Spacer(),
        cartButton(index)
      ],
    );
  }

  Widget cartQuantity(int index) {
    //return Text("1");
    // return Selector<CartPageController, int>(
    //     selector: (buildContext, cartPageController) =>
    //         cartPageController.count,
    //     builder: (context, datas, child) {
    return Container(
      child: Text(data[index]["qty"].toString(),
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
    );
    // });
  }

  Widget cartIncreDecre(int index) {
    return Row(
      children: [
        cartNegative(index),
        Padding(padding: EdgeInsets.only(left: 10.0)),
        cartPositive(index)
      ],
    );
  }

  Widget cartNegative(int index) {
    return Container(
      height: 40,
      width: 100,
      decoration: new BoxDecoration(
          color: Colors.red,
          borderRadius: new BorderRadius.all(Radius.circular(5))),
      child: IconButton(
        icon: Icon(
          Icons.exposure_minus_1,
          color: Colors.white,
        ),
        onPressed: () {
          Provider.of<CartPageController>(context, listen: false)
              .minusQuantity(index);
        },
      ),
    );
  }

  Widget cartPositive(int index) {
    return Container(
      height: 40,
      width: 100,
      decoration: new BoxDecoration(
          color: Colors.green,
          borderRadius: new BorderRadius.all(Radius.circular(5))),
      child: IconButton(
        icon: Icon(
          Icons.exposure_plus_1,
          color: Colors.white,
        ),
        onPressed: () {
          Provider.of<CartPageController>(context, listen: false)
              .addQuantity(index);
        },
      ),
    );
  }

  Widget cartButton(int index) {
    return GestureDetector(
      child: new Container(
        margin: EdgeInsets.only(top: 20),
        alignment: Alignment.center,
        width: 100,
        height: 30,
        decoration: new BoxDecoration(
            color: Colors.green,
            borderRadius: new BorderRadius.all(Radius.circular(5))),
        child: Text("Add",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ),
      onTap: () {
        Provider.of<CartPageController>(context, listen: false)
            .countItems(index);
      },
    );
  }

  Widget viewMore() {
    return GestureDetector(
      child: new Container(
        margin: EdgeInsets.only(top: 20),
        alignment: Alignment.center,
        width: double.infinity,
        height: 40,
        decoration: new BoxDecoration(
            color: Colors.blue,
            borderRadius: new BorderRadius.all(Radius.circular(5))),
        child: Text("View",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ),
      onTap: () {
        Provider.of<CartPageController>(context, listen: false)
            .isViewSelected(true);
        debugPrint("Vieww button clicked " + viewCart.toString());
      },
    );
  }

  Widget cartListSelected(index) {
    return Selector<CartPageController, bool>(
        selector: (buildContext, cartPageController) =>
            cartPageController.viewCart,
        builder: (context, data, child) {
          return Container(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(bottom: 10)),
                //cartListView(index)
                Visibility(visible: data, child: cartListView(index))
              ],
            ),
          );
        });
  }

  Widget cartListView(int index) {
    // return Selector<CartPageController, int>(
    //     selector: (buildContext, cartPageController) =>
    //         cartPageController.count,
    //     builder: (context, data, child) {
    return Container(
      child: Row(
        children: [
          Text(data[index]["Title"],
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          Spacer(),
          Text(data[index]["qty"].toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
        ],
      ),
    );
    //  });
  }
}

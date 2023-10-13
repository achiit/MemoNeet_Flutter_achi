import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';

Widget buildDropdownItem(
        {required Country country, required BuildContext context}) =>
    SizedBox(
      width: MediaQuery.of(context).size.width * 0.20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          5.horizontalSpace,
          Text("+${country.phoneCode}"),
        ],
      ),
    );
Widget buildDropdownItemWithoutFlag(Country country) => SizedBox(
      width: 50,
      child: Text("+${country.phoneCode}"),
    );
Widget buildDropdownCountry(Country country) => SizedBox(
      width: 193,
      child: Text(country.name),
    );

class CountryName extends StatefulWidget {
  final ValueChanged<String> onDateTimeChanged;

  const CountryName({Key? key, required this.onDateTimeChanged})
      : super(key: key);

  @override
  State<CountryName> createState() => _CountryNameState();
}

class _CountryNameState extends State<CountryName> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                errorStyle:
                    const TextStyle(color: Colors.redAccent, fontSize: 16.0),
                hintText: 'Please select Country',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: CountryPickerDropdown(
              itemBuilder: buildDropdownCountry,
              onValuePicked: (Country country) {
                widget.onDateTimeChanged(country.name.toString());
              },
            ),
          );
        },
      ),
    );
  }
}

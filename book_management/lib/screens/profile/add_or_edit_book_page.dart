import 'dart:io';

import 'package:book_management/models/authentication.dart';
import 'package:book_management/models/book_model.dart';
import 'package:book_management/utils/utils.dart';
import 'package:book_management/widget/buttons.dart';
import 'package:book_management/widget/textfileds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/colors.dart';

class AddOrEditBookPage extends StatefulWidget {
  final BookModel? book;
  const AddOrEditBookPage({super.key, required this.book});

  @override
  State<AddOrEditBookPage> createState() => _AddOrEditBookPageState();
}

class _AddOrEditBookPageState extends State<AddOrEditBookPage> {
  File? _imageFile;
  late TextEditingController titleController;
  late TextEditingController priceController;
  late TextEditingController genreController;
  late TextEditingController authorController;
  late TextEditingController pageCountController;
  bool loading = false;

  @override
  void initState() {
    titleController = TextEditingController(
        text: widget.book != null ? widget.book!.title : "");
    priceController = TextEditingController(
        text: widget.book != null ? "${widget.book!.price}" : "");
    genreController = TextEditingController(
        text: widget.book != null ? widget.book!.genre : "");
    authorController = TextEditingController(
        text: widget.book != null ? widget.book!.author : "");
    pageCountController = TextEditingController(
        text: widget.book != null ? "${widget.book!.pageCount}" : "");
    super.initState();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Icon(
                  CupertinoIcons.photo,
                  color: AppColors.textColor600,
                ),
                title: Text("انتخاب از گالری"),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Icon(
                  CupertinoIcons.camera,
                  color: AppColors.textColor600,
                ),
                title: Text("عکس گرفتن"),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget getImage() {
    if (_imageFile != null) {
      return Image.file(
        _imageFile!,
        fit: BoxFit.cover,
      );
    } else if (widget.book != null) {
      return Image.asset(
        widget.book!.imagePath,
        fit: BoxFit.cover,
      );
    } else {
      return Icon(Icons.add);
    }
  }

  void addOrUpdateBookApi(BookModel book) async {
    if (book.id.isEmpty) {
      // todo add
    } else {
      // todo update
    }
    setState(() {
      loading = false;
    });
    await Future.delayed(Duration(seconds: 3));
    BookModel.fakeData.add(book);
    Navigator.of(context).pop();
    showMessage(context, "کتاب با موفقیت ثبت شد");
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.textColor25,
                  border: Border(
                      bottom:
                          BorderSide(color: AppColors.textColor100, width: 2))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 28,
                  ),
                  Text(
                    widget.book == null
                        ? "افزودن کتاب"
                        : "ویرایش ${widget.book!.title}",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      _showImagePickerOptions(context);
                    },
                    child: Container(
                      width: 100,
                      height: 115,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor300,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: getImage(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        _showImagePickerOptions(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Text(
                          "انتخاب عکس",
                          style: Theme.of(context).textTheme.titleMedium!.apply(
                              color: AppColors.primaryColor300,
                              fontWeightDelta: 3),
                        ),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  AppTextFiledWidget(
                      labelText: "عنوان کتاب",
                      textInputType: TextInputType.text,
                      textEditingController: titleController,
                      needAutoCorrect: true,
                      isPassword: false),
                  SizedBox(
                    height: 15,
                  ),
                  AppTextFiledWidget(
                      labelText: "قیمت کتاب",
                      textInputType: TextInputType.number,
                      textEditingController: priceController,
                      needAutoCorrect: false,
                      isPassword: false),
                  SizedBox(
                    height: 15,
                  ),
                  AppTextFiledWidget(
                      labelText: "ژانر کتاب",
                      textInputType: TextInputType.text,
                      textEditingController: genreController,
                      needAutoCorrect: true,
                      isPassword: false),
                  SizedBox(
                    height: 15,
                  ),
                  AppTextFiledWidget(
                      labelText: "نویسنده کتاب",
                      textInputType: TextInputType.text,
                      textEditingController: authorController,
                      needAutoCorrect: true,
                      isPassword: false),
                  SizedBox(
                    height: 15,
                  ),
                  AppTextFiledWidget(
                      labelText: "تعداد صفحات کتاب",
                      textInputType: TextInputType.number,
                      textEditingController: pageCountController,
                      needAutoCorrect: true,
                      isPassword: false),
                  SizedBox(
                    height: 30,
                  ),
                  AppButtonWidget(
                    buttonText: "ثبت کتاب",
                    loading: loading,
                    onPressed: () {
                      if (_imageFile == null && widget.book == null) {
                        showError(context, "عکس کتاب نمی تواند خالی باشد");
                        return;
                      }
                      if (titleController.text.isEmpty) {
                        showError(context, "عنوان نمی تواند خالی باشد");
                        return;
                      }

                      if (priceController.text.isEmpty) {
                        showError(context, "قیمت نمی تواند خالی باشد");
                        return;
                      }

                      if (!intIsValid(priceController.text)) {
                        showError(
                            context, "قیمت باید عدد مثبت بدون اعشار باشد");
                        return;
                      }

                      if (genreController.text.isEmpty) {
                        showError(context, "ژانر نمی تواند خالی باشد");
                        return;
                      }

                      if (authorController.text.isEmpty) {
                        showError(context, "نویسنده نمی تواند خالی باشد");
                        return;
                      }

                      if (pageCountController.text.isEmpty) {
                        showError(
                            context, "تعداد صفحات کتاب نمی تواند خالی باشد");
                        return;
                      }

                      if (!intIsValid(pageCountController.text)) {
                        showError(context,
                            "صفحات کتاب باید عدد مثبت بدون اعشار باشد");
                        return;
                      }

                      String title = titleController.text;
                      String author = authorController.text;
                      String genre = genreController.text;
                      int price = int.parse(priceController.text);
                      int pageCount = int.parse(pageCountController.text);
                      String path = "";
                      bool localImage = false;

                      if (_imageFile != null) {
                        localImage = true;
                        path = _imageFile!.path;
                      } else {
                        localImage = false;
                        path = widget.book!.imagePath;
                      }

                      String id = "";
                      if (widget.book != null) {
                        id = widget.book!.id;
                      }
                      String userId = Authentication.user!.id;

                      BookModel book = BookModel(false,
                          title: title,
                          price: price,
                          id: id,
                          imagePath: path,
                          genre: genre,
                          localImage: localImage,
                          author: author,
                          isSoled: false,
                          pageCount: pageCount,
                          userId: userId);
                      setState(() {
                        loading = true;
                      });
                      addOrUpdateBookApi(book);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool intIsValid(String input) {
    bool isint = int.tryParse(input) != null;
    if (isint) {
      if (int.parse(input) > 0) {
        return true;
      }
    }
    return false;
  }
}

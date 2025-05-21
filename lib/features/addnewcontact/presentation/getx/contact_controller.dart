import 'package:chatapp/features/addnewcontact/domain/model/contact_model.dart';
import 'package:chatapp/features/addnewcontact/domain/usecase/get_contacts.usecase.repo.dart';
import 'package:get/state_manager.dart';

class ContactController extends GetxController {
  final GetContactsUsecase getContactsUsecase;
  ContactController({required this.getContactsUsecase});

  final Rxn<List<ContactModel>> allContacts = Rxn<List<ContactModel>>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("getting contact...");
    getContacts();
  }

  void getContacts() async {
    final result = await getContactsUsecase.call();

    result.fold(
      (failure) {
        print("Error occurred: ${failure.message}");
      },
      (data) {
        allContacts.value = data['matchedContacts'];
        print("All  Contacts that is saved in state: ${allContacts.value}");
      },
    );
  }
}

import 'package:flutter/material.dart';

class SettingsPolicy extends StatelessWidget {
  const SettingsPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        backgroundColor: const Color.fromARGB(255, 96, 128, 118),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),

          child: ListView(
            children: const [
               Padding(padding: EdgeInsets.all(8.0),
            child:
              Text('\n\nPrivacy Policy', style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),),
               ),
                Padding(padding: EdgeInsets.all(8.0),
            child:
              Text("\nPaperwork built the Paperwork app as a Free app. \nThis SERVICE is provided by Paperwork at no cost and is intended for use as is. \n This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service. \n If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. \nI will not use or share your information with anyone except as described in this Privacy Policy.\n\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Paperwork unless otherwise defined in this Privacy Policy.\n\nInformation Collection and Use\n\nFor a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to email adress, name, surname, langage. The information that I request will be retained on your device and is not collected by me in any way\nThe app does use third-party services that may collect information used to identify you\n\nLink to the privacy policy of third-party service providers used by the ap    \n\n   Google Play Service    \n    Faceboo\n\nLog Dat\n\nI want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. \nThis Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics\n\nCookie\n\nCookies are files with a small amount of data that are commonly used as anonymous unique identifiers. \nThese are sent to your browser from the websites that you visit and are stored on your device's internal memory\nThis Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. \nIf you choose to refuse our cookies, you may not be able to use some portions of this Service\n\nService Provider\n\nI may employ third-party companies and individuals due to the following reasons    \n    To facilitate our Service    \n    To provide the Service on our behalf    \n    To perform Service-related services; o    \n    To assist us in analyzing how our Service is used\nI want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose\n\n Securit\n\n I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. \nBut remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security\n\nLinks to Other Site\n\nThis Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. \nI have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services\n\nChildren’s Privac\n\nThese Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. \nIf you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do the necessary actions\n\nChanges to This Privacy Polic\n\nI may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page\n\nThis policy is effective as of 2023-03-3\n\nContact U\n\nIf you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at paperwork_2024@labeip.epitech.eu.", 
              style : TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 16), ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


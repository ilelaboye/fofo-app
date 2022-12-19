import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/gap.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Terms and privacy"),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.md,
              vertical: Insets.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Terms and Conditions",
                      style: context.textTheme.headlineMedium
                          .changeColor(AppColors.primary)
                          .size(19)
                          .bold,
                    ),
                  ],
                ),
                Gap.md,
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome to TrailBlazer Femme App!",
                    style: context.textTheme.caption
                        .size(15)
                        .copyWith(height: 1.4),
                  ),
                ),
                Gap.md,
                Text(
                  "These terms and conditions outline the rules and regulations for the use of TrailBlazer Femme App.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                Text(
                  "By using this app we assume you accept these terms and conditions. Do not continue to use TrailBlazer Femme App if you do not agree to take all of the terms and conditions stated on this page.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                Text(
                  "The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: 'Client', 'You' and 'Your' refers to you, the person log on this website and compliant to the Company’s terms and conditions. 'The Company', 'Ourselves', 'We', 'Our' and 'Us', refers to our Company. 'Party', 'Parties', or 'Us', refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client’s needs in respect of provision of the Company’s stated services, in accordance with and subject to, prevailing law of Netherlands. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same. Our Terms and Conditions were created with the help of the App Terms and Conditions Generator from App-Privacy-Policy.com",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                Text(
                  "License",
                  style: context.textTheme.headlineMedium
                      .changeColor(AppColors.primary)
                      .size(19)
                      .bold,
                ),
                Gap.md,
                Text(
                  "Unless otherwise stated, TrailBlazer Femme App and/or its licensors own the intellectual property rights for all material on TrailBlazer Femme App. All intellectual property rights are reserved. You may access this from TrailBlazer Femme App for your own personal use subjected to restrictions set in these terms and conditions.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                Text(
                  "You must not:",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                BulletList([
                  'Republish material from TrailBlazer Femme App',
                  'Sell, rent or sub-license material from TrailBlazer Femme App',
                  'Reproduce, duplicate or copy material from TrailBlazer Femme App',
                  'Redistribute content from TrailBlazer Femme App'
                ]),
                Gap.md,
                Text(
                  "This Agreement shall begin on the date hereof.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                Text(
                  "Parts of this app offer an opportunity for users to post and exchange opinions and information in certain areas of the website. TrailBlazer Femme App does not filter, edit, publish or review Comments prior to their presence on the website. Comments do not reflect the views and opinions of TrailBlazer Femme App, its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, TrailBlazer Femme App shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this website.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                Text(
                  "TrailBlazer Femme App reserves the right to monitor all Comments and to remove any Comments which can be considered inappropriate, offensive or causes breach of these Terms and Conditions.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Text(
                  "TrailBlazer Femme App reserves the right to monitor all Comments and to remove any Comments which can be considered inappropriate, offensive or causes breach of these Terms and Conditions.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Text(
                  "You warrant and represent that:",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                BulletList([
                  'You are entitled to post the Comments on our App and have all necessary licenses and consents to do so;',
                  'The Comments do not invade any intellectual property right, including without limitation copyright, patent or trademark of any third party;',
                  'The Comments do not contain any defamatory, libelous, offensive, indecent or otherwise unlawful material which is an invasion of privacy',
                  'The Comments will not be used to solicit or promote business or custom or present commercial activities or unlawful activity.'
                ]),
                Text(
                  "You hereby grant TrailBlazer Femme App a non-exclusive license to use, reproduce, edit and authorize others to use, reproduce and edit any of your Comments in any and all forms, formats or media.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hyperlinking to our App",
                      style: context.textTheme.headlineMedium
                          .changeColor(AppColors.primary)
                          .size(19)
                          .bold,
                    ),
                  ],
                ),
                Gap.md,
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "The following organizations may link to our App without prior written approval:",
                    style: context.textTheme.caption
                        .size(15)
                        .copyWith(height: 1.4),
                  ),
                ),
                BulletList(const [
                  'Government agencies;',
                  'Search engines;',
                  'News organizations;',
                  'Online directory distributors may link to our App in the same manner as they hyperlink to the Websites of other listed businesses; and',
                  'System wide Accredited Businesses except soliciting non-profit organizations, charity shopping malls, and charity fundraising groups which may not hyperlink to our Web site.'
                ]),
                Gap.md,
                Text(
                  "These organizations may link to our home page, to publications or to other App information so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products and/or services; and (c) fits within the context of the linking party’s site.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                Text(
                  "We may consider and approve other link requests from the following types of organizations:",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                BulletList(const [
                  'commonly-known consumer and/or business information sources;',
                  'dot.com community sites;',
                  'associations or other groups representing charities;',
                  'online directory distributors;',
                  'internet portals;',
                  'accounting, law and consulting firms; and',
                  'educational institutions and trade associations.'
                ]),
                Gap.md,
                Text(
                  "We will approve link requests from these organizations if we decide that: (a) the link would not make us look unfavorably to ourselves or to our accredited businesses; (b) the organization does not have any negative records with us; (c) the benefit to us from the visibility of the hyperlink compensates the absence of TrailBlazer Femme App; and (d) the link is in the context of general resource information.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                Text(
                  "These organizations may link to our App so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products or services; and (c) fits within the context of the linking party’s site.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                Text(
                  "If you are one of the organizations listed in paragraph 2 above and are interested in linking to our App, you must inform us by sending an e-mail to TrailBlazer Femme App. Please include your name, your organization name, contact information as well as the URL of your site, a list of any URLs from which you intend to link to our App, and a list of the URLs on our site to which you would like to link. Wait 2-3 weeks for a response.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                Text(
                  "Approved organizations may hyperlink to our App as follows:",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                BulletList(const [
                  'By use of our corporate name; or',
                  'By use of the uniform resource locator being linked to; or',
                  'By use of any other description of our App being linked to that makes sense within the context and format of content on the linking party’s site.',
                ]),
                Gap.md,
                Text(
                  "No use of TrailBlazer Femme App's logo or other artwork will be allowed for linking absent a trademark license agreement.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "iFrames",
                      style: context.textTheme.headlineMedium
                          .changeColor(AppColors.primary)
                          .size(19)
                          .bold,
                    ),
                  ],
                ),
                Gap.md,
                Text(
                  "Without prior approval and written permission, you may not create frames around our Webpages that alter in any way the visual presentation or appearance of our App.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Content Liablity",
                      style: context.textTheme.headlineMedium
                          .changeColor(AppColors.primary)
                          .size(19)
                          .bold,
                    ),
                  ],
                ),
                Gap.md,
                Text(
                  "We shall not be hold responsible for any content that appears on your App. You agree to protect and defend us against all claims that is rising on our App. No link(s) should appear on any Website that may be interpreted as libelous, obscene or criminal, or which infringes, otherwise violates, or advocates the infringement or other violation of, any third party rights.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Your Privacy",
                      style: context.textTheme.headlineMedium
                          .changeColor(AppColors.primary)
                          .size(19)
                          .bold,
                    ),
                  ],
                ),
                Gap.md,
                Text(
                  "Please read Privacy Policy.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Reservation of Rights",
                      style: context.textTheme.headlineMedium
                          .changeColor(AppColors.primary)
                          .size(19)
                          .bold,
                    ),
                  ],
                ),
                Gap.md,
                Text(
                  "We reserve the right to request that you remove all links or any particular link to our App. You approve to immediately remove all links to our App upon request. We also reserve the right to amen these terms and conditions and it’s linking policy at any time. By continuously linking to our App, you agree to be bound to and follow these linking terms and conditions.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Removal of links from our App",
                      style: context.textTheme.headlineMedium
                          .changeColor(AppColors.primary)
                          .size(19)
                          .bold,
                    ),
                  ],
                ),
                Gap.md,
                Text(
                  "If you find any link on our App that is offensive for any reason, you are free to contact and inform us any moment. We will consider requests to remove links but we are not obligated to or so or to respond to you directly.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                Text(
                  "We do not ensure that the information on this website is correct, we do not warrant its completeness or accuracy; nor do we promise to ensure that the website remains available or that the material on the website is kept up to date.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Disclaimer",
                      style: context.textTheme.headlineMedium
                          .changeColor(AppColors.primary)
                          .size(19)
                          .bold,
                    ),
                  ],
                ),
                Gap.md,
                Text(
                  "To the maximum extent permitted by applicable law, we exclude all representations, warranties and conditions relating to our App and the use of this website. Nothing in this disclaimer will:",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                BulletList(const [
                  'limit or exclude our or your liability for death or personal injury;',
                  'limit or exclude our or your liability for fraud or fraudulent misrepresentation',
                  'limit any of our or your liabilities in any way that is not permitted under applicable law; or',
                  'exclude any of our or your liabilities that may not be excluded under applicable law.',
                ]),
                Text(
                  "The limitations and prohibitions of liability set in this Section and elsewhere in this disclaimer: (a) are subject to the preceding paragraph; and (b) govern all liabilities arising under the disclaimer, including liabilities arising in contract, in tort and for breach of statutory duty.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
                Gap.md,
                Text(
                  "As long as the website and the information and services on the website are provided free of charge, we will not be liable for any loss or damage of any nature.",
                  style:
                      context.textTheme.caption.size(15).copyWith(height: 1.4),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> strings;

  BulletList(this.strings);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(16, 15, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((str) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\u2022',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.55,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    str,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.6),
                      height: 1.55,
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

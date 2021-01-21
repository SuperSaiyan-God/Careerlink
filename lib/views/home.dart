import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Careerlink/constants.dart';
import 'package:Careerlink/models/company.dart';
import 'package:Careerlink/views/job_detail.dart';
import 'package:Careerlink/widgets/company_card.dart';
import 'package:Careerlink/widgets/company_card2.dart';
import 'package:Careerlink/widgets/recent_job_card.dart';
import 'package:Careerlink/widgets/all_job_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Careerlink/utilities/google_sign_in.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: kSilver,
      appBar: AppBar(
        title: Text("Careerlink", style: TextStyle(color: Colors.black)),
        backgroundColor: kSilver,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            top: 12.0,
            bottom: 12.0,
            right: 12.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              "assets/user.svg",
              width: 25.0,
              color: kBlack,
            ),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
          ),
          SizedBox(width: 10.0)
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 25.0),
              Text(
                "Hi " +
                    user.displayName.split(" ")[0] +
                    ",\nFind your Dream Job",
                style: kPageTitleStyle,
              ),
              SizedBox(height: 40.0),
              Text(
                "Popular Company",
                style: kTitleStyle,
              ),
              SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                height: 190.0,
                child: ListView.builder(
                  itemCount: companyList.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var company = companyList[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobDetail(
                              company: company,
                            ),
                          ),
                        );
                      },
                      child: index == 0
                          ? CompanyCard(company: company)
                          : CompanyCard2(company: company),
                    );
                  },
                ),
              ),
              SizedBox(height: 35.0),
              Text(
                "Recent Jobs",
                style: kTitleStyle,
              ),
              ListView.builder(
                itemCount: recentList.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  var recent = recentList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JobDetail(
                            company: recent,
                          ),
                        ),
                      );
                    },
                    child: RecentJobCard(company: recent),
                  );
                },
              ),
              SizedBox(height: 35.0),
              Text(
                "All Jobs",
                style: kTitleStyle,
              ),
              ListView.builder(
                itemCount: allList.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  var all = allList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JobDetail(
                            company: all,
                          ),
                        ),
                      );
                    },
                    child: AllJobCard(company: all),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

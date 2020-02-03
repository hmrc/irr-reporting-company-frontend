#!/bin/bash

echo ""
echo "Applying migration $className;format="snake"$"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
export kebabClassName=\$(sed --expression 's/\([^A-Z]\)\([A-Z0-9]\)/\1-\2/g' --expression 's/\([A-Z0-9]\)\([A-Z0-9]\)\([^A-Z]\)/\1-\2\3/g' <<< "$className$" | tr '[:upper:]' '[:lower:]')

echo "GET        /\$kebabClassName                       controllers.$className$Controller.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /\$kebabClassName                        controllers.$className$Controller.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /\$kebabClassName-change                  controllers.$className$Controller.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /\$kebabClassName-change                  controllers.$className$Controller.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to English conf.messages"
echo "" >> ../conf/messages.en
echo "" >> ../conf/messages.en
echo "# $className$Page Messages" >> ../conf/messages.en
echo "# ----------------------------------------------------------" >> ../conf/messages.en
echo "$className;format="decap"$.title = $className$" >> ../conf/messages.en
echo "$className;format="decap"$.heading = $className$" >> ../conf/messages.en
echo "$className;format="decap"$.checkYourAnswersLabel = $className$" >> ../conf/messages.en
echo "$className;format="decap"$.error.required.all = Please enter the date for $className;format="decap"$" >> ../conf/messages.en
echo "$className;format="decap"$.error.required.two = The $className;format="decap"$" must include {0} and {1} >> ../conf/messages.en
echo "$className;format="decap"$.error.required = The $className;format="decap"$ must include {0}" >> ../conf/messages.en
echo "$className;format="decap"$.error.invalid = Enter a real date" >> ../conf/messages.en

echo ""
echo "Adding messages to Welsh conf.messages"
echo "" >> ../conf/messages.cy
echo "" >> ../conf/messages.cy
echo "# $className$Page Messages" >> ../conf/messages.cy
echo "# ----------------------------------------------------------" >> ../conf/messages.cy
echo "$className;format="decap"$.title = $className$" >> ../conf/messages.cy
echo "$className;format="decap"$.heading = $className$" >> ../conf/messages.cy
echo "$className;format="decap"$.checkYourAnswersLabel = $className$" >> ../conf/messages.cy
echo "$className;format="decap"$.error.required.all = Enter the $className;format="decap"$" >> ../conf/messages.cy
echo "$className;format="decap"$.error.required.two = The $className;format="decap"$" must include {0} and {1} >> ../conf/messages.cy
echo "$className;format="decap"$.error.required = The $className;format="decap"$ must include {0}" >> ../conf/messages.cy
echo "$className;format="decap"$.error.invalid = Enter a real $className$" >> ../conf/messages.cy

echo ""
echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitrary$className$UserAnswersEntry: Arbitrary[($className$Page.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[$className$Page.type]";\
    print "        value <- arbitrary[Int].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo ""
echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitrary$className$Page: Arbitrary[$className$Page.type] =";\
    print "    Arbitrary($className$Page)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo ""
echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[($className$Page.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo ""
echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "  def $className;format="decap"$: Option[SummaryListRow] = answer($className$Page, routes.$className$Controller.onPageLoad(CheckMode))";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration $className;format="snake"$ completed"

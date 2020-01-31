#!/bin/bash

echo ""
echo "Applying migration TEST000000000000000000000000"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /TEST000000000000000000000000                        controllers.TEST000000000000000000000000Controller.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /TEST000000000000000000000000                        controllers.TEST000000000000000000000000Controller.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeTEST000000000000000000000000                  controllers.TEST000000000000000000000000Controller.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeTEST000000000000000000000000                  controllers.TEST000000000000000000000000Controller.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to English conf.messages"
echo "" >> ../conf/messages.en
echo "" >> ../conf/messages.en
echo "# TEST000000000000000000000000Page Messages" >> ../conf/messages.en
echo "# ----------------------------------------------------------" >> ../conf/messages.en
echo "tEST000000000000000000000000.title = tEST000000000000000000000000" >> ../conf/messages.en
echo "tEST000000000000000000000000.heading = tEST000000000000000000000000" >> ../conf/messages.en
echo "tEST000000000000000000000000.option1 = Option 1" >> ../conf/messages.en
echo "tEST000000000000000000000000.option2 = Option 2" >> ../conf/messages.en
echo "tEST000000000000000000000000.checkYourAnswersLabel = tEST000000000000000000000000" >> ../conf/messages.en
echo "tEST000000000000000000000000.error.required = Select tEST000000000000000000000000" >> ../conf/messages.en

echo "Adding messages to Welsh conf.messages"
echo "" >> ../conf/messages.cy
echo "" >> ../conf/messages.cy
echo "# TEST000000000000000000000000Page Messages" >> ../conf/messages.cy
echo "# ----------------------------------------------------------" >> ../conf/messages.cy
echo "tEST000000000000000000000000.title = tEST000000000000000000000000" >> ../conf/messages.cy
echo "tEST000000000000000000000000.heading = tEST000000000000000000000000" >> ../conf/messages.cy
echo "tEST000000000000000000000000.option1 = Option 1" >> ../conf/messages.cy
echo "tEST000000000000000000000000.option2 = Option 2" >> ../conf/messages.cy
echo "tEST000000000000000000000000.checkYourAnswersLabel = tEST000000000000000000000000" >> ../conf/messages.cy
echo "tEST000000000000000000000000.error.required = Select tEST000000000000000000000000" >> ../conf/messages.cy

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryTEST000000000000000000000000UserAnswersEntry: Arbitrary[(TEST000000000000000000000000Page.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[TEST000000000000000000000000Page.type]";\
    print "        value <- arbitrary[TEST000000000000000000000000].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryTEST000000000000000000000000Page: Arbitrary[TEST000000000000000000000000Page.type] =";\
    print "    Arbitrary(TEST000000000000000000000000Page)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to ModelGenerators"
awk '/trait ModelGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryTEST000000000000000000000000: Arbitrary[TEST000000000000000000000000] =";\
    print "    Arbitrary {";\
    print "      Gen.oneOf(TEST000000000000000000000000.values.toSeq)";\
    print "    }";\
    next }1' ../test/generators/ModelGenerators.scala > tmp && mv tmp ../test/generators/ModelGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(TEST000000000000000000000000Page.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class/ {\
     print;\
     print "";\
     print "  def tEST000000000000000000000000: Option[SummaryListRow] = answer(TEST000000000000000000000000Page, routes.TEST000000000000000000000000Controller.onPageLoad(CheckMode))";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration TEST000000000000000000000000 completed"

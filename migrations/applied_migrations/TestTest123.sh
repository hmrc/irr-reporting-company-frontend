#!/bin/bash

echo ""
echo "Applying migration TestTest123"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /TestTest123                        controllers.TestTest123Controller.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /TestTest123                        controllers.TestTest123Controller.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeTestTest123                  controllers.TestTest123Controller.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeTestTest123                  controllers.TestTest123Controller.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to English conf.messages"
echo "" >> ../conf/messages.en
echo "" >> ../conf/messages.en
echo "# TestTest123Page Messages" >> ../conf/messages.en
echo "# ----------------------------------------------------------" >> ../conf/messages.en
echo "testTest123.title = testTest123" >> ../conf/messages.en
echo "testTest123.heading = testTest123" >> ../conf/messages.en
echo "testTest123.option1 = Option 1" >> ../conf/messages.en
echo "testTest123.option2 = Option 2" >> ../conf/messages.en
echo "testTest123.checkYourAnswersLabel = testTest123" >> ../conf/messages.en
echo "testTest123.error.required = Select testTest123" >> ../conf/messages.en

echo "Adding messages to Welsh conf.messages"
echo "" >> ../conf/messages.cy
echo "" >> ../conf/messages.cy
echo "# TestTest123Page Messages" >> ../conf/messages.cy
echo "# ----------------------------------------------------------" >> ../conf/messages.cy
echo "testTest123.title = testTest123" >> ../conf/messages.cy
echo "testTest123.heading = testTest123" >> ../conf/messages.cy
echo "testTest123.option1 = Option 1" >> ../conf/messages.cy
echo "testTest123.option2 = Option 2" >> ../conf/messages.cy
echo "testTest123.checkYourAnswersLabel = testTest123" >> ../conf/messages.cy
echo "testTest123.error.required = Select testTest123" >> ../conf/messages.cy

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryTestTest123UserAnswersEntry: Arbitrary[(TestTest123Page.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[TestTest123Page.type]";\
    print "        value <- arbitrary[TestTest123].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryTestTest123Page: Arbitrary[TestTest123Page.type] =";\
    print "    Arbitrary(TestTest123Page)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to ModelGenerators"
awk '/trait ModelGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryTestTest123: Arbitrary[TestTest123] =";\
    print "    Arbitrary {";\
    print "      Gen.oneOf(TestTest123.values.toSeq)";\
    print "    }";\
    next }1' ../test/generators/ModelGenerators.scala > tmp && mv tmp ../test/generators/ModelGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(TestTest123Page.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class/ {\
     print;\
     print "";\
     print "  def testTest123: Option[SummaryListRow] = answer(TestTest123Page, routes.TestTest123Controller.onPageLoad(CheckMode))";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration TestTest123 completed"

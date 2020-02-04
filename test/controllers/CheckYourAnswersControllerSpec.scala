/*
 * Copyright 2020 HM Revenue & Customs
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package controllers

import assets.messages.CheckYourAnswersMessages
import base.SpecBase
import config.featureSwitch.FeatureSwitching
import controllers.actions._
import play.api.test.Helpers._
import views.html.CheckYourAnswersView

class CheckYourAnswersControllerSpec extends SpecBase with FeatureSwitching {

  val view = injector.instanceOf[CheckYourAnswersView]

  def controller(dataRetrieval: DataRetrievalAction = FakeDataRetrievalActionEmptyAnswers) = new CheckYourAnswersController(
    messagesApi = messagesApi,
    identify = FakeIdentifierAction,
    getData = dataRetrieval,
    requireData = injector.instanceOf[DataRequiredActionImpl],
    controllerComponents = messagesControllerComponents,
    view = view
  )

  "Check Your Answers Controller" must {

    "return a OK (200) when given empty answers" in {

      val result = controller().onPageLoad()(fakeRequest)

      status(result) mustEqual OK
      titleOf(contentAsString(result)) mustEqual title(CheckYourAnswersMessages.title)
    }
  }
}

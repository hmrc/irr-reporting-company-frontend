/*
 * Copyright 2019 HM Revenue & Customs
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

package views

import controllers.routes
import forms.HelloWorldYesNoFormProvider
import models.NormalMode
import nunjucks.viewmodels.YesNoRadioViewModel
import play.api.data.Form
import play.api.libs.json.Json
import play.twirl.api.Html
import uk.gov.hmrc.nunjucks.NunjucksSupport
import views.behaviours.YesNoViewBehaviours

class HelloWorldYesNoNunjucksViewSpec extends YesNoViewBehaviours with NunjucksSupport {

  val messageKeyPrefix = "helloWorldYesNoNunjucks"

  val form = new HelloWorldYesNoFormProvider()()

  "HelloWorldYesNoNunjucks view" must {

    def applyView(form: Form[Boolean]): Html =
      await(nunjucksRenderer.render(nunjucks.HelloWorldYesNoTemplate, Json.toJsObject(YesNoRadioViewModel(form, NormalMode)))(fakeRequest))

    behave like normalPage(applyView(form), messageKeyPrefix)

    behave like pageWithBackLink(applyView(form))

    behave like yesNoPage(form = form,
                          createView = applyView,
                          messageKeyPrefix = messageKeyPrefix,
                          expectedFormAction = routes.HelloWorldYesNoController.onSubmit(NormalMode).url)

    behave like pageWithSignOutLink(applyView(form))
  }
}

package views

import java.time.LocalDate

import forms.$className$FormProvider
import models.NormalMode
import play.api.data.Form
import play.api.libs.json.Json
import play.twirl.api.HtmlFormat
import uk.gov.hmrc.viewmodels.Radios
import views.behaviours.QuestionViewBehaviours
import views.html.$className$View
class $className$ViewSpec extends QuestionViewBehaviours[LocalDate] {

  val messageKeyPrefix = "$className;format="decap"$"

  val form = new $className$FormProvider()()def applyView(form: Form[_]): HtmlFormat.Appendable = {
          val view = viewFor[$className$View](Some(emptyUserAnswers))
          view.apply(form, NormalMode)(fakeRequest, messages, frontendAppConfig)
        }

      behave like normalPage(applyView(form), messageKeyPrefix)

      behave like pageWithBackLink(applyView(form))
    }

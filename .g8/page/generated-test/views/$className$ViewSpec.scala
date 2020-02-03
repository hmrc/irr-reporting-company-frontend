package views

import views.behaviours.ViewBehaviours
import views.html.$className$View
import views._

class $className$ViewSpec extends ViewBehaviours {

  lazy val viewTemplate = viewFor[$className$View](Some(emptyUserAnswers))
  lazy val view = viewTemplate.apply()(fakeRequest, frontendAppConfig, messages)


  s"$className$View" must {

    behave like normalPage(view, "$className;format="decap"$"
    )

    behave like pageWithBackLink(view)
  }
}

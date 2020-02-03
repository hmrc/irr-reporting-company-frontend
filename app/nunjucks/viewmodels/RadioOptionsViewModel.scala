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

package nunjucks.viewmodels

import models.Mode
import play.api.data.Form
import play.api.i18n.Messages
import play.api.libs.json.{Json, OWrites}
import uk.gov.hmrc.govukfrontend.views.viewmodels.radios.RadioItem
case class RadioOptionsViewModel[T](options: Seq[RadioItem], form: Form[T], mode: Mode)(implicit messages: Messages)


object RadioOptionsViewModel extends NunjucksSupport {

  implicit def writes[T](implicit messages: Messages): OWrites[RadioOptionsViewModel[T]] = OWrites { model =>
    Json.obj(
      "form"   -> model.form,
      "radios" -> model.options,
      "mode" -> model.mode
    )
  }
}





#!/bin/bash

echo ""
echo "Applying migration $className;format="snake"$"

echo "Adding routes to conf/app.routes"
echo "" >> ../conf/app.routes
export kebabClassName=\$(sed --expression 's/\([^A-Z]\)\([A-Z0-9]\)/\1-\2/g' --expression 's/\([A-Z0-9]\)\([A-Z0-9]\)\([^A-Z]\)/\1-\2\3/g' <<< "$className$" | tr '[:upper:]' '[:lower:]')

echo "GET        /\$kebabClassName                       controllers.$className$Controller.onPageLoad()" >> ../conf/app.routes

echo "Adding messages to English conf.messages"
echo "" >> ../conf/messages.en
echo "" >> ../conf/messages.en
echo "# $className$Page Messages" >> ../conf/messages.en
echo "# ----------------------------------------------------------" >> ../conf/messages.en
echo "$className;format="decap"$.title = $className;format="decap"$" >> ../conf/messages.en
echo "$className;format="decap"$.heading = $className;format="decap"$" >> ../conf/messages.en

echo "Adding messages to Welsh conf.messages"
echo "" >> ../conf/messages.cy
echo "" >> ../conf/messages.cy
echo "# $className$Page Messages" >> ../conf/messages.cy
echo "# ----------------------------------------------------------" >> ../conf/messages.cy
echo "$className;format="decap"$.title = $className;format="decap"$" >> ../conf/messages.cy
echo "$className;format="decap"$.heading = $className;format="decap"$" >> ../conf/messages.cy

echo "Migration $className;format="snake"$ completed"

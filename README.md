# Stipra
<div align="left">
The Stipra Ecosystem was a product of TeknTrash: it was the first service which effectively rewarded people for proper recycling while providing companies with unique post-sales data. The ecosystem was made of an app, a monitoring website, and a network of StipraPOD ("Point of Disposal") connected<br><br>

This repository is the app of the Stipra system. The app uses the camera to read barcodes, send their data to a backend server, and finally the video to be processed. The backend then processes the video, looking for barcodes, checks with an online service what is the name of the product of that barcode, and if there is a reward associated. It then sends a message to the user with the points obtained. It also shows how many points the user has, where did he make videos, what is his level, etc, much like any reward system<br><br>

This code is therefore quite useful as a basis for a camera system able to send videos to be studied, and also as a basis for a loyalty system, where points are awarded to users and they can trade it for perks<br><br>

This code is developed in Flutter and can run in Android and IOS<br><br>

<b>Future improvements</b><br>
1 - NFC card reader to login to the StipraPOD network of smart bins using the mobile without having to carry a card<br>
2 - Connection with loyalty systems (Nectar, BP, ASDA, etc) as to integrate with their systems and obtain rewards
<div>

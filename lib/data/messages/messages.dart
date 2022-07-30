import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          //Earn Page
          'earn_page_title': 'Earn',
          'earn_page_no_offers_available': 'No offers available',
          'earn_page_category_all': 'All',
          'earn_page_category_automotive': 'Automotive',
          'earn_page_category_baby': 'Baby',
          'earn_page_category_books': 'Books',
          'earn_page_category_camera_photo': 'Camera & Photo',
          'earn_page_category_cds_vinyl': 'CDs & Vinyl',
          'earn_page_category_clothing': 'Clothing',
          'earn_page_category_computers_accessories': 'Computers & Accessories',
          'earn_page_category_dvd_blu_ray': 'DVD & Blu-ray',
          'earn_page_category_electronics_mobiles': 'Electronics & Mobiles',
          'earn_page_category_fashion': 'Fashion',
          'earn_page_category_garden_outdoors': 'Garden & Outdoors',
          'earn_page_category_groceries_food': 'Groceries and Food',
          'earn_page_category_health_personal_care': 'Health & Personal Care',
          'earn_page_category_home_kitchen': 'Home & Kitchen',
          'earn_page_category_industrial_scientific': 'Industrial & Scientific',
          'earn_page_category_jewellery': 'Jewellery',
          'earn_page_category_large_appliances': 'Large Appliances',
          'earn_page_category_lighting': 'Lighting',
          'earn_page_category_luggage': 'Luggage',
          'earn_page_category_magazines': 'Magazines',
          'earn_page_category_musical_instruments_dj_equipment':
              'Musical Instruments & DJ Equipment',
          'earn_page_category_office_products': 'Office Products',
          'earn_page_category_pc_video_games': 'PC & Video Games',
          'earn_page_category_perfume_cosmetic': 'Perfume & Cosmetic',
          'earn_page_category_pet_supplies': 'Pet Supplies',
          'earn_page_category_shoes_handbags': 'Shoes & Handbags',
          'earn_page_category_sports': 'Sports',
          'earn_page_category_toys_games': 'Toys & Games',
          'earn_page_category_watches': 'Watches',
          'earn_page_filter_title': 'Show with',
          'earn_page_filter_expired': 'Expired',
          'earn_page_filter_outside_my_area': 'Outside my area',
          'earn_page_product_points': '@points Points',
          //Redeem Page
          'redeem_page_title': 'Redeem',
          'redeem_page_category_all': 'All',
          'redeem_page_category_discounts': 'Discounts',
          'redeem_page_category_exclusiveoffers': 'Exclusive Offers',
          'redeem_page_category_freetrials': 'Free trials',
          'redeem_page_category_gaming': 'Gaming',
          'redeem_page_category_giftcards': 'Gift Cards',
          'redeem_page_category_merchandise': 'Merchandise',
          'redeem_page_category_products': 'Products',
          'redeem_page_category_supportacause': 'Support a Cause',
          'redeem_page_no_redeem': 'No redeem available',
          'redeem_page_include_expired': 'Include expired',
          'redeem_page_starting_from': 'Starting from',
          'redeem_page_redeemed_points': '@points Points redeemed ',
          //Home
          'search_button_hint_text': 'Search',
          'top_bar_points': '@points Points',
          'top_bar_sign_in': 'Sign in',
          'bottom_navigation_bar_earn_label': 'Earn',
          'bottom_navigation_bar_redeem_label': 'Redeem',
          'bottom_navigation_bar_make_video_label': 'Make video',
          'bottom_navigation_bar_profile_label': 'Profile',
          'bottom_navigation_bar_info_label': 'Info',
          //Profile Page
          'profile_page_profile_title': 'Profile',
          'profile_page_my_profile_button_text': 'My Profile',
          'profile_page_privacy_button_text': 'Privacy',
          'profile_page_my_earnings_button_text': 'My Earnings',
          'profile_page_my_level_button_text': 'My Level',
          'profile_page_my_redeems_button_text': 'My Redeems',
          'profile_page_videos_waiting_button_text': 'Videos Waiting',
          'profile_page_logout_button_text': 'Logout',
          //My Profile Page
          'my_profile_page_title': 'My profile',
          'my_profile_page_edit_profile_button_text': 'Edit Profile',
          'my_profile_page_remove_profile_button_text': 'Remove Profile',
          'my_profile_page_change_password_button_text': 'Change Password',
          'my_profile_page_change_email_button_text': 'Change Email',
          //Edit Profile Page
          'change_your_profile_title': 'Change your profile',
          'change_your_profile_field_title_address': 'Address',
          'change_your_profile_field_title_country': 'Country',
          'change_your_profile_field_title_city': 'City',
          'change_your_profile_field_title_zipcode': 'Zipcode',
          'change_your_profile_field_title_gender': 'Gender',
          'change_your_profile_field_title_date_of_birth': 'Date of birth',
          'change_your_profile_field_hint_address': 'Enter your address',
          'change_your_profile_field_hint_country': 'Select a country',
          'change_your_profile_field_hint_city': 'Enter your city',
          'change_your_profile_field_hint_zipcode': 'Enter your zipcode',
          'change_your_profile_field_hint_gender': 'Select your gender',
          'change_your_profile_field_hint_date_of_birth': 'Select date',
          'change_your_profile_confirm': 'Confirm',
          'gender_male': 'Male',
          'gender_female': 'Female',
          //Change Email Page
          'change_email_title': 'Change your email',
          'change_email_subtitle':
              'Enter your new email address to change then we will send verify code.',
          'change_email_current_email_title': 'Current Email',
          'change_email_new_email_title': 'New Email',
          'change_email_new_email_hint': 'Enter New Email',
          'change_email_confirm_button_text': 'Confirm',
          //Change Email OTP Page
          'change_email_otp_didnt_receive_code': 'Didn\'t receive the code? ',
          'change_email_otp_resend': 'RESEND',
          'change_email_otp_resend_wait':
              'Please wait before resending the code ',
          'change_email_otp_all_right_reserved': 'Stipra all rights reserved',
          //Change Password Page
          'change_password_title': 'Change your password',
          'change_password_subtitle':
              'Enter your old password and new password to change.',
          'change_password_current_password_title': 'Old Password',
          'change_password_new_password_title': 'New Password',
          'change_password_confirm_button_text': 'Confirm',
          //Remove Profile Page
          'remove_profile_title': 'Remove your profile',
          'remove_profile_subtitle':
              'This will remove all your data in Stipra. Warning! This is irreversible. If that\'s ok insert please your password',
          'remove_profile_current_password_title': 'Current Password',
          'remove_profile_current_password_hint': 'Password',
          'remove_profile_confirm_button_text': 'Confirm',
          //Privacy Page
          'privacy_title': 'Privacy',
          'privacy_receive_newsletter': 'Receive newsletter',
          'privacy_receive_email': 'Receive emails with points',
          'privacy_receive_mobile_notification': 'Receive mobile notifications',
          //My Earnings Page
          'my_earnings_title': 'My Earnings',
          'my_earnings_not_exists_text':
              'You don\'t have any products yet. Make videos of your household garbage as you dispose of the individual items and you will earn points',
          'my_earnings_scan_button_text': 'Scan',
          'my_earnings_order_by_text': 'Order by @type',
          'my_earnings_order_type_barcode': 'barcode',
          'my_earnings_order_type_label': 'name',
          'my_earnings_order_type_datetimetaken': 'date',
          'my_earnings_scan_button': 'Scan',
          'my_earnings_subtitle_points': '@points Points per product',
          'my_earnings_subtitle_consumed_singular': 'Consumed @number time',
          'my_earnings_subtitle_consumed_plural': 'Consumed @number times',
          'my_earnings_consumed_on': 'Consumed on:',
          //My Level Page
          'my_level_title': 'My Level',
          'my_level_other_levels': 'Other levels',
          'my_level_progression_subtitle_text':
              'You have to collect @points points to reach this level',
          'my_level_my_points': '@points Points',
          'my_level_next_level_points_description':
              'You need @points Points to become @levelName',
          'my_level_level_name_grasshopper': 'Grasshopper',
          'my_level_level_name_frog': 'Frog',
          'my_level_level_name_snake': 'Snake',
          'my_level_level_name_eagle': 'Eagle',
          //My Redeems Page
          'my_redeems_title': 'My Redeems',
          'my_redeems_no_redeem': 'No redeem available',
          'my_redeems_redeemed_points_title': '@points Points redeemed ',
          'my_redeems_redeemed_on': 'Redeemed on:',
          'my_redeems_': 'a',
          //Videos Waiting Page
          'videos_waiting_title': 'Videos Waiting',
          'videos_waiting_subtitle':
              'Below the videos you made which are waiting to be sent automatically as soon as you reach a wifi location. That way you do not spend data on your contract.',
          'videos_waiting_item_scanned_on_text': 'Scanned on:',
          'videos_waiting_upload_now_button_title': 'Upload now',
          'videos_waiting_cancel_button_title': 'Cancel',
          'videos_waiting_no_waiting_videos': 'All of your videos uploaded!',
          //Videos Delete Dialog Page
          'videos_delete_description': 'Are you sure to delete this video?',
          'video_delete_button_delete': 'Delete',
          'video_delete_button_cancel': 'Cancel',
          //Search Page
          'search_page_search_button_hint': 'Search',
          'search_page_group_title_earn': 'Earn',
          'search_page_group_title_redeem': 'Redeem',
          'search_page_no_result': 'We couldn\'t find any results.',
          'search_page_start_search': 'Start searching to find offers.',
          'search_page_earn_points': '@points Points',
          'search_page_redeem_level': 'Level @level',
          //INFO SECTION
          'info_page_title': 'Info',
          'info_page_what_is_stipra': 'What is Stipra',
          'info_page_how_to_make_a_video': 'How to make a Video',
          'info_page_points_and_levels': 'Points and levels',
          'info_page_contact': 'Contact',
          //What is Stipra
          'what_is_stipra_title': 'What is Stipra',
          'what_is_stipra_text':
              'Give your trash meaning! Stipra is an innovative system that allows you to receive points for each household consumer product that you normally throw out after you use.\n\nFor that, you download the app, make a video of your garbage as you throw the products in each bin, and receive points after they are recognized.\n\nStipra accepts products you use in your home as long as they have a barcode: a shampoo, a sardine can, a wine bottle, a beer can, a canned food ...\n\nAll products must have been consumed by you and can be thrown in any bin as long as it is located in the geographical area the manufacturer set up.\n\nFor that it is necessary that you have the GPS activated so that the system identifies the location. And, if you can throw them in the correct recycling bin (you know: plastic in yellow, glass in green ...) even better.',
          'what_is_stipra_below_text':
              'Each picture or video is immediately analyzed by our Artificial Intelligence system and, once the products are identified, it gives you the corresponding points and you get an email.\n\nAs for the points, you can exchange them for products, trips, gifts, promotions...: in your client area you can see how many points you have and redeem them.',
          //How to make a Video
          'how_to_make_a_video_title': 'How to make a Video',
          'how_to_make_a_video_text':
              'To make a video of your general household trash, click on "Make Video" from the app and show the products as you dispose them in the recycling bins.\n\nYou can also do a video of just one product by clicking on the link at that product.\n\nThe video will start in 3 seconds and will run for up to 60 seconds. You can stop it at any time and choose whether or not you want to send it.\n\nEnsure you show the barcodes! Each time a barcode is seen, the app will tell you and will vibrate, then you can show the next product.\n\nThe video will only be sent for analysis when you reach a wifi: that way we will not spend your mobile data. \n\nOnce the video reaches our servers, it is analyzed and you will receive in minutes an email with your points.\n\nSee below an example of a video.',
          //Points and levels
          'points_and_levels_title': 'Points and levels',
          'points_and_levels_text':
              'Make videos to earn points and trade them for perks.',
          'points_and_levels_sub_text':
              'Some perks however require a minimum amount of points to be traded. For that, Stipra has 4 levels based on the amount of points you collected: Grasshopper, Frog, Snake, and Eagle',
          'points_and_levels_collected':
              'You have collected at least @points points',
          //Contact Page
          'contact_title': 'Contact',
          'contact_title_name_field_title': 'Name',
          'contact_title_name_field_hint': 'Enter your name',
          'contact_title_email_field_title': 'Email',
          'contact_title_email_field_hint': 'Enter your email',
          'contact_title_message_field_title': 'Message',
          'contact_title_message_field_hint': 'Enter your message',
          'contact_title_send_button_text': 'Send',
          //Captcha dialog
          'captcha_title': 'Captcha',
          'captcha_enter_number': 'Enter Number',
          'captcha_check_button': 'Check',
          'captcha_invalid_code': 'Invalid code',
          //Product detail page
          'product_detail_title': 'Detail',
          'product_detail_description': 'Description',
          'product_detail_valid_until': 'Valid until',
          'product_detail_points': '@points Points',
          'product_detail_scan_button': 'Scan',
          //Nutrients page
          'nutrients_title': 'Nutrients',
          'nutrients_subtitle': 'These values are shown per 100g.',
          'nutrients_proteins': 'Protein',
          'nutrients_carbohydrates': 'Carbohydrate',
          'nutrients_energy': 'Energy',
          'nutrients_fats': 'Fats',
          'nutrients_salt': 'Salt',
          'nutrients_saturated_fats': 'Saturated fats',
          'nutrients_soddium': 'Sodium',
          'nutrients_sugar': 'Sugar',
          'nutrients_max_per_100g': 'Max @value per day',
          'nutrients_gauge_poor': 'Poor',
          'nutrients_gauge_fair': 'Fair',
          'nutrients_gauge_good': 'Good',
          'nutrients_gauge_great': 'Great',
          'nutrients_gauge_excellent': 'Excellent',
          //Map page
          'map_title': 'Right bin for this:',
          'map_subtitle': 'Get points from disposing this product in this area',
          //Perk detail page
          'perk_detail_title': 'Detail',
          'perk_detail_description': 'Description',
          'perk_detail_valid_until': 'Valid until',
          'perk_detail_points': '@points Points',
          'perk_detail_level': 'Level: @level',
          'perk_detail_button': 'Trade',
          //Trade dialog
          'trade_subtitle':
              'You can change the perk amount by tapping the number buttons.',
          'trade_button_trade': 'Trade @points Points',
          'trade_button_cancel': 'Cancel',
          'trade_you_can_not_trade':
              'You can not trade more than @points points',
          //My Product detail page
          //Featured
          //Login Page
          //Register Page
          //Board Page
          //Utils
          'text_field_error_message': 'This field can not be empty.',
        },
        'tr_TR': {
          //Earn Page
          'earn_page_title': 'Kazan',
          'earn_page_no_offers_available': 'Şu an hiç teklif yok',
          'earn_page_category_all': 'Hepsi',
          'earn_page_category_automotive': 'Otomotiv',
          'earn_page_category_baby': 'Bebek',
          'earn_page_category_books': 'Kitap',
          'earn_page_category_camera_photo': 'Kamera ve fotoğraf',
          'earn_page_category_cds_vinyl': 'CD & Vinyl',
          'earn_page_category_clothing': 'Giyim',
          'earn_page_category_computers_accessories':
              'Bilgisayar ve bileşenleri',
          'earn_page_category_dvd_blu_ray': 'DVD & Blu-ray',
          'earn_page_category_electronics_mobiles': 'Elektronik ve mobil',
          'earn_page_category_fashion': 'Moda',
          'earn_page_category_garden_outdoors': 'Bahçe ve dış süsleme',
          'earn_page_category_groceries_food': 'Gıda ve içecek',
          'earn_page_category_health_personal_care': 'Sağlık ve kişisel bakım',
          'earn_page_category_home_kitchen': 'Ev ve mutfak',
          'earn_page_category_industrial_scientific': 'Endüstri ve bilimsel',
          'earn_page_category_jewellery': 'Mücevher',
          'earn_page_category_large_appliances': 'Büyük aygıtlar',
          'earn_page_category_lighting': 'Işık',
          'earn_page_category_luggage': 'Valiz',
          'earn_page_category_magazines': 'Dergiler',
          'earn_page_category_musical_instruments_dj_equipment':
              'Müzik aletleri ve DJ ekipmanları',
          'earn_page_category_office_products': 'Ofis ürünleri',
          'earn_page_category_pc_video_games': 'PC ve Video oyunları',
          'earn_page_category_perfume_cosmetic': 'Parfüm ve Kozmetiz',
          'earn_page_category_pet_supplies': 'Evcil hayvan malzemeleri',
          'earn_page_category_shoes_handbags': 'Ayakkabı ve El çantaları',
          'earn_page_category_sports': 'Spor',
          'earn_page_category_toys_games': 'Oyuncaklar ve Oyunlar',
          'earn_page_category_watches': 'Saatler',
          'earn_page_filter_title': 'Şunlarla göster:',
          'earn_page_filter_expired': 'Süresi dolan',
          'earn_page_filter_outside_my_area': 'Bölgemin dışındakiler',
          'earn_page_product_points': '@points Puan',
          //Redeem Page
          'redeem_page_title': 'Dönüştür',
          'redeem_page_category_all': 'Hepsi',
          'redeem_page_category_discounts': 'İndirimler',
          'redeem_page_category_exclusiveoffers': 'Özel teklifler',
          'redeem_page_category_freetrials': 'Ücretsiz deneme',
          'redeem_page_category_gaming': 'Oyun',
          'redeem_page_category_giftcards': 'Hediye kartları',
          'redeem_page_category_merchandise': 'Eşyalar',
          'redeem_page_category_products': 'Ürünler',
          'redeem_page_category_supportacause': 'Bir amaca destek ol',
          'redeem_page_no_redeem': 'Henüz dönüştürübileceğin bir teklif yok.',
          'redeem_page_include_expired': 'Eskileri dahil et',
          'redeem_page_starting_from': 'Başlangıç seviyesi',
          'redeem_page_redeemed_points': '@points Points redeemed ',
          //Home
          'search_button_hint_text': 'Ara',
          'top_bar_points': '@points Puan',
          'top_bar_sign_in': 'Giriş yap',
          'bottom_navigation_bar_earn_label': 'Kazan',
          'bottom_navigation_bar_redeem_label': 'Dönüştür',
          'bottom_navigation_bar_make_video_label': 'Video kaydet',
          'bottom_navigation_bar_profile_label': 'Profil',
          'bottom_navigation_bar_info_label': 'Bilgi',
          //Profile Page
          'profile_page_profile_title': 'Profil',
          'profile_page_my_profile_button_text': 'Benim profilim',
          'profile_page_privacy_button_text': 'Gizlilik',
          'profile_page_my_earnings_button_text': 'Kazandıklarım',
          'profile_page_my_level_button_text': 'Seviye bilgilerim',
          'profile_page_my_redeems_button_text': 'Dönüştürdüklerim',
          'profile_page_videos_waiting_button_text': 'Bekleyen videolar',
          'profile_page_logout_button_text': 'Çıkış',
          //My Profile Page
          'my_profile_page_title': 'Profilim',
          'my_profile_page_edit_profile_button_text': 'Profilimi düzenle',
          'my_profile_page_remove_profile_button_text': 'Profilimi sil',
          'my_profile_page_change_password_button_text': 'Şifremi değiştir',
          'my_profile_page_change_email_button_text': 'E-posta değiştir',
          //Edit Profile Page
          'change_your_profile_title': 'Profilimi değiştir',
          'change_your_profile_field_title_address': 'Adres',
          'change_your_profile_field_title_country': 'Ülke',
          'change_your_profile_field_title_city': 'Şehir',
          'change_your_profile_field_title_zipcode': 'Posta kodu',
          'change_your_profile_field_title_gender': 'Cinsiyet',
          'change_your_profile_field_title_date_of_birth': 'Doğum tarihi',
          'change_your_profile_field_hint_address': 'Adresini gir',
          'change_your_profile_field_hint_country': 'Bir ülke seç',
          'change_your_profile_field_hint_city': 'Şehrinizi girin',
          'change_your_profile_field_hint_zipcode': 'Posta kodunuzu girin',
          'change_your_profile_field_hint_gender': 'Cinsiyetinizi seçin',
          'change_your_profile_field_hint_date_of_birth': 'Tarih seçin',
          'change_your_profile_confirm': 'Onayla',
          'gender_male': 'Erkek',
          'gender_female': 'Kadın',
          //Change Email Page
          'change_email_title': 'E-posta değiştir',
          'change_email_subtitle':
              'Yeni e-posta adresini gir. Bu girdiğin adrese bir onay kodu gönderilecek.',
          'change_email_current_email_title': 'Mevcut e-posta',
          'change_email_new_email_title': 'Yeni e-posta',
          'change_email_new_email_hint': 'Yeni e-posta adresini gir',
          'change_email_confirm_button_text': 'Değiştir',
          //Change Email OTP Page
          'change_email_otp_didnt_receive_code': 'Kod adresine ulaşmadı mı? ',
          'change_email_otp_resend': 'TEKRAR GÖNDER',
          'change_email_otp_resend_wait':
              'Lütfen kodu tekrar göndermeden önce bekleyiniz ',
          'change_email_otp_all_right_reserved': 'Stipra tüm hakları saklıdır',
          //Change Password Page
          'change_password_title': 'Şifre değiştir',
          'change_password_subtitle':
              'Şifreni değiştirmek için mevcut şifreni ve oluşturmak istediğin yeni şifreyi gir.',
          'change_password_current_password_title': 'Mevcut şifre',
          'change_password_new_password_title': 'Yeni şifre',
          'change_password_confirm_button_text': 'Onayla',
          //Remove Profile Page
          'remove_profile_title': 'Profilimi sil',
          'remove_profile_subtitle':
              'Bu işlem Stipra sunucularından tüm bilgilerinizi silecektir. Bu işlemi yaparken dikkat edin çünkü bu işlem tersine çevrilemez! Eğer devam etmek istiyorsanız lütfen şifrenizi girin.',
          'remove_profile_current_password_title': 'Mevcut şifre',
          'remove_profile_current_password_hint': 'Şifrenizi girin',
          'remove_profile_confirm_button_text': 'Sil',
          //Privacy Page
          'privacy_title': 'Gizlilik',
          'privacy_receive_newsletter': 'Bültenler e-posta ile iletilsin',
          'privacy_receive_email': 'Puanlarım e-posta ile iletilsin',
          'privacy_receive_mobile_notification':
              'Telefon bildirimleri iletilsin',
          //My Earnings Page
          'my_earnings_title': 'Kazandıklarım',
          'my_earnings_not_exists_text':
              'Henüz dönüştürdüğünüz bir ürün yok. Evdeki ürünlerinizi çöpe atarken videosunu çekerek tek tek tarayın ve puan kazanın.',
          'my_earnings_scan_button_text': 'Tara',
          'my_earnings_order_by_text': 'Sırala: @type',
          'my_earnings_order_type_barcode': 'barkod',
          'my_earnings_order_type_label': 'isim',
          'my_earnings_order_type_datetimetaken': 'tarih',
          'my_earnings_scan_button': 'Tara',
          'my_earnings_subtitle_points': '@points Puan (ürün başına)',
          'my_earnings_subtitle_consumed_singular': '@number kez tüketildi',
          'my_earnings_subtitle_consumed_plural': '@number kez tüketildi',
          'my_earnings_consumed_on': 'Tüketim tarihi:',
          //My Level Page
          'my_level_title': 'Seviye bilgilerim',
          'my_level_other_levels': 'Diğer seviyeler',
          'my_level_progression_subtitle_text':
              'Bu seviyeye ulaşmak için @points puan daha toplaman gerekiyor',
          'my_level_my_points': '@points Puan',
          'my_level_next_level_points_description':
              '@levelName olmak için @points puana ihtiyacın var',
          'my_level_level_name_grasshopper': 'Çekirge',
          'my_level_level_name_frog': 'Kurbağa',
          'my_level_level_name_snake': 'Yılan',
          'my_level_level_name_eagle': 'Kartal',
          //My Redeems Page
          'my_redeems_title': 'Dönüştürdüklerim',
          'my_redeems_no_redeem': 'Herhangi bir dönüştürme yapmamışsınız.',
          'my_redeems_redeemed_points_title': '@points Puan dönüştürüldü ',
          'my_redeems_redeemed_on': 'İşlem tarihi:',
          'my_redeems_': 'a',
          //Videos Waiting Page
          'videos_waiting_title': 'Bekleyen videolar',
          'videos_waiting_subtitle':
              'Aşağıda bir wifi ağına sahip olduğunuzda gönderilmeyi bekleyen videolarınız var. Bu sayede mobil verinizden internet harcamamış olursunuz.',
          'videos_waiting_item_scanned_on_text': 'Tarama tarihi:',
          'videos_waiting_upload_now_button_title': 'Videoları gönder',
          'videos_waiting_cancel_button_title': 'İptal et',
          'videos_waiting_no_waiting_videos': 'Tüm videolarınız gönderilmiş!',
          //Videos Delete Dialog Page
          'videos_delete_description':
              'Bu videoyu silmek istediğine emin misin?',
          'video_delete_button_delete': 'Sil',
          'video_delete_button_cancel': 'Vazgeç',
          //Search Page
          'search_page_search_button_hint': 'Ara',
          'search_page_group_title_earn': 'Kazan',
          'search_page_group_title_redeem': 'Dönüştür',
          'search_page_no_result': 'Herhangi bir sonuç bulunamadı.',
          'search_page_start_search': 'Fırsatları görebilmek için arama yap.',
          'search_page_earn_points': '@points Puan',
          'search_page_redeem_level': 'Seviye @level',
          //INFO SECTION
          'info_page_title': 'Bilgi',
          'info_page_what_is_stipra': 'Stipra nedir',
          'info_page_how_to_make_a_video': 'Video nasıl oluşturulur',
          'info_page_points_and_levels': 'Puanlar ve seviyeler',
          'info_page_contact': 'İletişim',
          //What is Stipra
          'what_is_stipra_title': 'Stipra nedir',
          'what_is_stipra_text':
              'Çöpünüze değer verin! Stipra, normalde kullandıktan sonra çöpe attığınız her ürün için puan almanızı sağlayan yenilikçi bir sistemdir.\n\nBunun için uygulamayı indirirsiniz, ürünlerinizi çöp kutusuna atarken çöpünüzün videosunu çekersiniz ve ürünleriniz video ile tanındıktan sonra puan kazanırsınız.\n\nEvinizde kullandığınız ürünlerin barkodlu olması yeterlidir: şampuan, sardalya kutusu, kola şişesi, konserve ...\n\nÜrünlerden puan kazanabilmeniz için tüm ürünler sizin tarafınızdan tüketilmiş olmalı ve üreticinin belirlediği alanda herhangi bir çöp kutusuna atılmalıdır.\n\nÜrünü atabileceğiniz bölgeyi görebilmek için GPS\'i etkinleştirmeniz gerekir. Tükettiğiniz ürünleri doğru geri dönüşüm kutusuna atabilirseniz daha iyi olur.',
          'what_is_stipra_below_text':
              'Her video, Yapay Zeka sistemimiz tarafından anında analiz edilir ve ürünler tanımlandıktan sonra size kazandığınız punlar verilir ve bununla ilgili bir bilgilendirme maili alırsınız.\n\nPuanları fırsatlardan yararlanarak; ürün, gezi, hediye gibi şeylere dönüştürebilirsiniz. Dönüştür kısmında bulunan fırsatlar ile puanlarınızı kullanabilirsiniz. Profilinizden ne kadar puanınız olduğunu görebilirsiniz.',
          //How to make a Video
          'how_to_make_a_video_title': 'Video nasıl oluşturulur',
          'how_to_make_a_video_text':
              'Çöpünüzü atarken videosunu çekmek için uygulamadan "Video kaydet"e tıklayın ve ürünleri geri dönüşüm kutularına atarken barkodlarını gösterin.\n\nBirden fazla ürün göstermek zorunda değilsiniz tek bir ürün için de video oluşturabilirisinz ancak unutmayın ne kadar çok ürün taratırsanız o kadar çok puan kazanma şansınız olur.\n\n"Video kaydet"e tıkladığınızda video 3 saniye içinde başlar ve durdurmamanız halinde 60 saniye boyunca kayıt yapacaktır. İstediğiniz zaman durdurabilir ve göndermek isteyip istemediğinizi seçebilirsiniz.\n\nVideo kaydederken ürünlerin barkodlarını gösterdiğinizden emin olun! Bir barkod her görüldüğünde, uygulama size söyleyecek ve titreyecektir, ardından bir sonraki ürünü gösterebileceksiniz.\n\nVideo, yalnızca bir Wi-Fi ağına bağlı olursanız otomatik olarak analiz için gönderilir: bu şekilde mobil verilerinizi harcamayız . \n\nVideo sunucularımıza ulaştığında analiz edilir ve dakikalar içinde puanlarınızı içeren bir e-posta alırsınız.\n\nAşağıda nasıl yapılacağına dair bir video bulunmakta dilerseniz izleyebilirsiniz.',
          //Points and levels
          'points_and_levels_title': 'Puanlar ve seviyeler',
          'points_and_levels_text':
              'Puan kazanmak için video kaydedin ve bu puanları tekliflerde kullanın.',
          'points_and_levels_sub_text':
              'Uygulamadaki bazı teklifler, takas edilmesi için minimum seviye ister. Bu fırsatlardan yararlanmanız için topladığınız puan miktarına göre 4 seviye vardır: Çekirge, Kurbağa, Yılan ve Kartal',
          'points_and_levels_collected':
              'Bu seviyeye ulaşmak için en az @points puan toplamalısın.',
          //Contact Page
          'contact_title': 'İletişim',
          'contact_title_name_field_title': 'İsim',
          'contact_title_name_field_hint': 'İsminizi girin',
          'contact_title_email_field_title': 'E-posta',
          'contact_title_email_field_hint': 'E-posta adresinizi girin',
          'contact_title_message_field_title': 'Mesaj',
          'contact_title_message_field_hint': 'Mesajınızı girin',
          'contact_title_send_button_text': 'Gönder',
          //Utils
          'text_field_error_message': 'Bu alan boş olamaz.',
        },
        'de_DE': {
          'hello': 'Hallo Welt',
        }
      };
}

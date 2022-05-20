// To parse this JSON data, do
//
//     final foodFactModel = foodFactModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class FoodFactModel {
  FoodFactModel({
    this.code,
    this.product,
    this.status,
    this.statusVerbose,
  });

  final String? code;
  final _Product? product;
  final int? status;
  final String? statusVerbose;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => FoodFactModel(
        code: json["code"] == null ? null : json["code"],
        product: json["product"] == null
            ? null
            : _Product().fromJson(json["product"]),
        status: json["status"] == null ? null : json["status"],
        statusVerbose:
            json["status_verbose"] == null ? null : json["status_verbose"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "product": product == null ? null : product?.toJson(),
        "status": status == null ? null : status,
        "status_verbose": statusVerbose == null ? null : statusVerbose,
      };
}

class _Product {
  _Product({
    this.id,
    this.keywords,
    this.addedCountriesTags,
    this.additivesOldTags,
    this.additivesOriginalTags,
    this.additivesTags,
    this.allergens,
    this.allergensFromIngredients,
    this.allergensFromUser,
    this.allergensHierarchy,
    this.allergensLc,
    this.allergensTags,
    this.aminoAcidsTags,
    this.brands,
    this.brandsTags,
    this.categories,
    this.categoriesHierarchy,
    this.categoriesLc,
    this.categoriesOld,
    this.categoriesProperties,
    this.categoriesPropertiesTags,
    this.categoriesTags,
    this.checkersTags,
    this.citiesTags,
    this.code,
    this.codesTags,
    this.comparedToCategory,
    this.complete,
    this.completeness,
    this.correctorsTags,
    this.countries,
    this.countriesHierarchy,
    this.countriesLc,
    this.countriesTags,
    this.createdT,
    this.creator,
    this.dataQualityBugsTags,
    this.dataQualityErrorsTags,
    this.dataQualityInfoTags,
    this.dataQualityTags,
    this.dataQualityWarningsTags,
    this.dataSources,
    this.dataSourcesTags,
    this.debugParamSortedLangs,
    this.downgraded,
    this.ecoscoreData,
    this.ecoscoreGrade,
    this.ecoscoreScore,
    this.ecoscoreTags,
    this.editorsTags,
    this.embCodes,
    this.embCodesTags,
    this.entryDatesTags,
    this.expirationDate,
    this.foodGroups,
    this.foodGroupsTags,
    this.genericName,
    this.genericNameEn,
    this.productId,
    this.imageFrontSmallUrl,
    this.imageFrontThumbUrl,
    this.imageFrontUrl,
    this.imageSmallUrl,
    this.imageThumbUrl,
    this.imageUrl,
    this.images,
    this.informersTags,
    this.ingredientsAnalysisTags,
    this.ingredientsFromPalmOilTags,
    this.ingredientsHierarchy,
    this.ingredientsText,
    this.ingredientsTextEn,
    this.ingredientsTextWithAllergens,
    this.ingredientsTextWithAllergensEn,
    this.ingredientsThatMayBeFromPalmOilTags,
    this.interfaceVersionCreated,
    this.interfaceVersionModified,
    this.labels,
    this.labelsHierarchy,
    this.labelsLc,
    this.labelsTags,
    this.lang,
    this.languages,
    this.languagesCodes,
    this.languagesHierarchy,
    this.languagesTags,
    this.lastEditDatesTags,
    this.lastEditor,
    this.lastImageDatesTags,
    this.lastImageT,
    this.lastModifiedBy,
    this.lastModifiedT,
    this.lc,
    this.link,
    this.mainCountriesTags,
    this.manufacturingPlaces,
    this.manufacturingPlacesTags,
    this.maxImgid,
    this.mineralsTags,
    this.miscTags,
    this.noNutritionData,
    this.novaGroupDebug,
    this.novaGroupTags,
    this.nucleotidesTags,
    this.nutrientLevels,
    this.nutrientLevelsTags,
    this.nutriments,
    this.nutriscoreData,
    this.nutriscoreGrade,
    this.nutriscoreScore,
    this.nutriscoreScoreOpposite,
    this.nutritionData,
    this.nutritionDataPer,
    this.nutritionDataPrepared,
    this.nutritionDataPreparedPer,
    this.nutritionGradeFr,
    this.nutritionGrades,
    this.nutritionGradesTags,
    this.nutritionScoreBeverage,
    this.nutritionScoreWarningNoFiber,
    this.nutritionScoreWarningNoFruitsVegetablesNuts,
    this.origins,
    this.originsHierarchy,
    this.originsLc,
    this.originsTags,
    this.otherNutritionalSubstancesTags,
    this.packaging,
    this.packagingHierarchy,
    this.packagingLc,
    this.packagingOld,
    this.packagingTags,
    this.packagingText,
    this.packagingTextEn,
    this.packagings,
    this.photographersTags,
    this.pnnsGroups1,
    this.pnnsGroups1Tags,
    this.pnnsGroups2,
    this.pnnsGroups2Tags,
    this.popularityKey,
    this.productName,
    this.productNameEn,
    this.purchasePlaces,
    this.purchasePlacesTags,
    this.quantity,
    this.removedCountriesTags,
    this.rev,
    this.selectedImages,
    this.sortkey,
    this.states,
    this.statesHierarchy,
    this.statesTags,
    this.stores,
    this.storesTags,
    this.traces,
    this.tracesFromIngredients,
    this.tracesFromUser,
    this.tracesHierarchy,
    this.tracesLc,
    this.tracesTags,
    this.unknownNutrientsTags,
    this.updateKey,
    this.vitaminsTags,
  });

  final String? id;
  final List<String>? keywords;
  final List<dynamic>? addedCountriesTags;
  final List<dynamic>? additivesOldTags;
  final List<dynamic>? additivesOriginalTags;
  final List<dynamic>? additivesTags;
  final String? allergens;
  final String? allergensFromIngredients;
  final String? allergensFromUser;
  final List<dynamic>? allergensHierarchy;
  final String? allergensLc;
  final List<dynamic>? allergensTags;
  final List<dynamic>? aminoAcidsTags;
  final String? brands;
  final List<String>? brandsTags;
  final String? categories;
  final List<String>? categoriesHierarchy;
  final String? categoriesLc;
  final String? categoriesOld;
  final CategoriesProperties? categoriesProperties;
  final List<String>? categoriesPropertiesTags;
  final List<String>? categoriesTags;
  final List<dynamic>? checkersTags;
  final List<dynamic>? citiesTags;
  final String? code;
  final List<String>? codesTags;
  final String? comparedToCategory;
  final int? complete;
  final double? completeness;
  final List<String>? correctorsTags;
  final String? countries;
  final List<String>? countriesHierarchy;
  final String? countriesLc;
  final List<String>? countriesTags;
  final int? createdT;
  final String? creator;
  final List<dynamic>? dataQualityBugsTags;
  final List<dynamic>? dataQualityErrorsTags;
  final List<String>? dataQualityInfoTags;
  final List<String>? dataQualityTags;
  final List<String>? dataQualityWarningsTags;
  final String? dataSources;
  final List<String>? dataSourcesTags;
  final List<String>? debugParamSortedLangs;
  final String? downgraded;
  final EcoscoreData? ecoscoreData;
  final EcoscoreGrade? ecoscoreGrade;
  final int? ecoscoreScore;
  final List<EcoscoreGrade>? ecoscoreTags;
  final List<String>? editorsTags;
  final String? embCodes;
  final List<dynamic>? embCodesTags;
  final List<String>? entryDatesTags;
  final String? expirationDate;
  final String? foodGroups;
  final List<String>? foodGroupsTags;
  final String? genericName;
  final String? genericNameEn;
  final String? productId;
  final String? imageFrontSmallUrl;
  final String? imageFrontThumbUrl;
  final String? imageFrontUrl;
  final String? imageSmallUrl;
  final String? imageThumbUrl;
  final String? imageUrl;
  final Images? images;
  final List<String>? informersTags;
  final List<String>? ingredientsAnalysisTags;
  final List<dynamic>? ingredientsFromPalmOilTags;
  final List<dynamic>? ingredientsHierarchy;
  final String? ingredientsText;
  final String? ingredientsTextEn;
  final String? ingredientsTextWithAllergens;
  final String? ingredientsTextWithAllergensEn;
  final List<dynamic>? ingredientsThatMayBeFromPalmOilTags;
  final String? interfaceVersionCreated;
  final String? interfaceVersionModified;
  final String? labels;
  final List<String>? labelsHierarchy;
  final String? labelsLc;
  final List<String>? labelsTags;
  final String? lang;
  final Languages? languages;
  final LanguagesCodes? languagesCodes;
  final List<String>? languagesHierarchy;
  final List<String>? languagesTags;
  final List<String>? lastEditDatesTags;
  final String? lastEditor;
  final List<String>? lastImageDatesTags;
  final int? lastImageT;
  final String? lastModifiedBy;
  final int? lastModifiedT;
  final String? lc;
  final String? link;
  final List<dynamic>? mainCountriesTags;
  final String? manufacturingPlaces;
  final List<dynamic>? manufacturingPlacesTags;
  final String? maxImgid;
  final List<dynamic>? mineralsTags;
  final List<String>? miscTags;
  final String? noNutritionData;
  final String? novaGroupDebug;
  final List<String>? novaGroupTags;
  final List<dynamic>? nucleotidesTags;
  final NutrientLevels? nutrientLevels;
  final List<String>? nutrientLevelsTags;
  final Nutriments? nutriments;
  final NutriscoreData? nutriscoreData;
  final String? nutriscoreGrade;
  final int? nutriscoreScore;
  final int? nutriscoreScoreOpposite;
  final String? nutritionData;
  final String? nutritionDataPer;
  final String? nutritionDataPrepared;
  final String? nutritionDataPreparedPer;
  final String? nutritionGradeFr;
  final String? nutritionGrades;
  final List<String>? nutritionGradesTags;
  final int? nutritionScoreBeverage;
  final int? nutritionScoreWarningNoFiber;
  final int? nutritionScoreWarningNoFruitsVegetablesNuts;
  final String? origins;
  final List<dynamic>? originsHierarchy;
  final String? originsLc;
  final List<dynamic>? originsTags;
  final List<dynamic>? otherNutritionalSubstancesTags;
  final String? packaging;
  final List<dynamic>? packagingHierarchy;
  final String? packagingLc;
  final String? packagingOld;
  final List<dynamic>? packagingTags;
  final String? packagingText;
  final String? packagingTextEn;
  final List<dynamic>? packagings;
  final List<String>? photographersTags;
  final String? pnnsGroups1;
  final List<String>? pnnsGroups1Tags;
  final String? pnnsGroups2;
  final List<String>? pnnsGroups2Tags;
  final int? popularityKey;
  final String? productName;
  final String? productNameEn;
  final String? purchasePlaces;
  final List<dynamic>? purchasePlacesTags;
  final String? quantity;
  final List<dynamic>? removedCountriesTags;
  final int? rev;
  final SelectedImages? selectedImages;
  final int? sortkey;
  final String? states;
  final List<String>? statesHierarchy;
  final List<String>? statesTags;
  final String? stores;
  final List<String>? storesTags;
  final String? traces;
  final String? tracesFromIngredients;
  final String? tracesFromUser;
  final List<dynamic>? tracesHierarchy;
  final String? tracesLc;
  final List<dynamic>? tracesTags;
  final List<dynamic>? unknownNutrientsTags;
  final String? updateKey;
  final List<dynamic>? vitaminsTags;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => _Product(
        id: json["_id"] == null ? null : json["_id"],
        keywords: json["_keywords"] == null
            ? null
            : List<String>.from(json["_keywords"]?.map((x) => x) ?? {}),
        addedCountriesTags: json["added_countries_tags"] == null
            ? null
            : List<dynamic>.from(
                json["added_countries_tags"]?.map((x) => x) ?? {}),
        additivesOldTags: json["additives_old_tags"] == null
            ? null
            : List<dynamic>.from(
                json["additives_old_tags"]?.map((x) => x) ?? {}),
        additivesOriginalTags: json["additives_original_tags"] == null
            ? null
            : List<dynamic>.from(
                json["additives_original_tags"]?.map((x) => x) ?? {}),
        additivesTags: json["additives_tags"] == null
            ? null
            : List<dynamic>.from(json["additives_tags"]?.map((x) => x) ?? {}),
        allergens: json["allergens"] == null ? null : json["allergens"],
        allergensFromIngredients: json["allergens_from_ingredients"] == null
            ? null
            : json["allergens_from_ingredients"],
        allergensFromUser: json["allergens_from_user"] == null
            ? null
            : json["allergens_from_user"],
        allergensHierarchy: json["allergens_hierarchy"] == null
            ? null
            : List<dynamic>.from(
                json["allergens_hierarchy"]?.map((x) => x) ?? {}),
        allergensLc: json["allergens_lc"] == null ? null : json["allergens_lc"],
        allergensTags: json["allergens_tags"] == null
            ? null
            : List<dynamic>.from(json["allergens_tags"]?.map((x) => x) ?? {}),
        aminoAcidsTags: json["amino_acids_tags"] == null
            ? null
            : List<dynamic>.from(json["amino_acids_tags"]?.map((x) => x) ?? {}),
        brands: json["brands"] == null ? null : json["brands"],
        brandsTags: json["brands_tags"] == null
            ? null
            : List<String>.from(json["brands_tags"]?.map((x) => x) ?? {}),
        categories: json["categories"] == null ? null : json["categories"],
        categoriesHierarchy: json["categories_hierarchy"] == null
            ? null
            : List<String>.from(
                json["categories_hierarchy"]?.map((x) => x) ?? {}),
        categoriesLc:
            json["categories_lc"] == null ? null : json["categories_lc"],
        categoriesOld:
            json["categories_old"] == null ? null : json["categories_old"],
        categoriesProperties: json["categories_properties"] == null
            ? null
            : CategoriesProperties().fromJson(json["categories_properties"]),
        categoriesPropertiesTags: json["categories_properties_tags"] == null
            ? null
            : List<String>.from(
                json["categories_properties_tags"]?.map((x) => x) ?? {}),
        categoriesTags: json["categories_tags"] == null
            ? null
            : List<String>.from(json["categories_tags"]?.map((x) => x) ?? {}),
        checkersTags: json["checkers_tags"] == null
            ? null
            : List<dynamic>.from(json["checkers_tags"]?.map((x) => x) ?? {}),
        citiesTags: json["cities_tags"] == null
            ? null
            : List<dynamic>.from(json["cities_tags"]?.map((x) => x) ?? {}),
        code: json["code"] == null ? null : json["code"],
        codesTags: json["codes_tags"] == null
            ? null
            : List<String>.from(json["codes_tags"]?.map((x) => x) ?? {}),
        comparedToCategory: json["compared_to_category"] == null
            ? null
            : json["compared_to_category"],
        complete: json["complete"] == null ? null : json["complete"],
        completeness: json["completeness"] == null
            ? null
            : json["completeness"].toDouble(),
        correctorsTags: json["correctors_tags"] == null
            ? null
            : List<String>.from(json["correctors_tags"]?.map((x) => x) ?? {}),
        countries: json["countries"] == null ? null : json["countries"],
        countriesHierarchy: json["countries_hierarchy"] == null
            ? null
            : List<String>.from(
                json["countries_hierarchy"]?.map((x) => x) ?? {}),
        countriesLc: json["countries_lc"] == null ? null : json["countries_lc"],
        countriesTags: json["countries_tags"] == null
            ? null
            : List<String>.from(json["countries_tags"]?.map((x) => x) ?? {}),
        createdT: json["created_t"] == null ? null : json["created_t"],
        creator: json["creator"] == null ? null : json["creator"],
        dataQualityBugsTags: json["data_quality_bugs_tags"] == null
            ? null
            : List<dynamic>.from(
                json["data_quality_bugs_tags"]?.map((x) => x) ?? {}),
        dataQualityErrorsTags: json["data_quality_errors_tags"] == null
            ? null
            : List<dynamic>.from(
                json["data_quality_errors_tags"]?.map((x) => x) ?? {}),
        dataQualityInfoTags: json["data_quality_info_tags"] == null
            ? null
            : List<String>.from(
                json["data_quality_info_tags"]?.map((x) => x) ?? {}),
        dataQualityTags: json["data_quality_tags"] == null
            ? null
            : List<String>.from(json["data_quality_tags"]?.map((x) => x) ?? {}),
        dataQualityWarningsTags: json["data_quality_warnings_tags"] == null
            ? null
            : List<String>.from(
                json["data_quality_warnings_tags"]?.map((x) => x) ?? {}),
        dataSources: json["data_sources"] == null ? null : json["data_sources"],
        dataSourcesTags: json["data_sources_tags"] == null
            ? null
            : List<String>.from(json["data_sources_tags"]?.map((x) => x) ?? {}),
        debugParamSortedLangs: json["debug_param_sorted_langs"] == null
            ? null
            : List<String>.from(
                json["debug_param_sorted_langs"]?.map((x) => x) ?? {}),
        downgraded: json["downgraded"] == null ? null : json["downgraded"],
        ecoscoreData: json["ecoscore_data"] == null
            ? null
            : EcoscoreData().fromJson(json["ecoscore_data"]),
        ecoscoreGrade: json["ecoscore_grade"] == null
            ? null
            : ecoscoreGradeValues.map[json["ecoscore_grade"]],
        ecoscoreScore:
            json["ecoscore_score"] == null ? null : json["ecoscore_score"],
        ecoscoreTags: json["ecoscore_tags"] == null
            ? null
            : List<EcoscoreGrade>.from(
                json["ecoscore_tags"].map((x) => ecoscoreGradeValues.map[x])),
        editorsTags: json["editors_tags"] == null
            ? null
            : List<String>.from(json["editors_tags"]?.map((x) => x) ?? {}),
        embCodes: json["emb_codes"] == null ? null : json["emb_codes"],
        embCodesTags: json["emb_codes_tags"] == null
            ? null
            : List<dynamic>.from(json["emb_codes_tags"]?.map((x) => x) ?? {}),
        entryDatesTags: json["entry_dates_tags"] == null
            ? null
            : List<String>.from(json["entry_dates_tags"]?.map((x) => x) ?? {}),
        expirationDate:
            json["expiration_date"] == null ? null : json["expiration_date"],
        foodGroups: json["food_groups"] == null ? null : json["food_groups"],
        foodGroupsTags: json["food_groups_tags"] == null
            ? null
            : List<String>.from(json["food_groups_tags"]?.map((x) => x) ?? {}),
        genericName: json["generic_name"] == null ? null : json["generic_name"],
        genericNameEn:
            json["generic_name_en"] == null ? null : json["generic_name_en"],
        productId: json["id"] == null ? null : json["id"],
        imageFrontSmallUrl: json["image_front_small_url"] == null
            ? null
            : json["image_front_small_url"],
        imageFrontThumbUrl: json["image_front_thumb_url"] == null
            ? null
            : json["image_front_thumb_url"],
        imageFrontUrl:
            json["image_front_url"] == null ? null : json["image_front_url"],
        imageSmallUrl:
            json["image_small_url"] == null ? null : json["image_small_url"],
        imageThumbUrl:
            json["image_thumb_url"] == null ? null : json["image_thumb_url"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        images:
            json["images"] == null ? null : Images().fromJson(json["images"]),
        informersTags: json["informers_tags"] == null
            ? null
            : List<String>.from(json["informers_tags"]?.map((x) => x) ?? {}),
        ingredientsAnalysisTags: json["ingredients_analysis_tags"] == null
            ? null
            : List<String>.from(
                json["ingredients_analysis_tags"]?.map((x) => x) ?? {}),
        ingredientsFromPalmOilTags: json["ingredients_from_palm_oil_tags"] ==
                null
            ? null
            : List<dynamic>.from(
                json["ingredients_from_palm_oil_tags"]?.map((x) => x) ?? {}),
        ingredientsHierarchy: json["ingredients_hierarchy"] == null
            ? null
            : List<dynamic>.from(
                json["ingredients_hierarchy"]?.map((x) => x) ?? {}),
        ingredientsText:
            json["ingredients_text"] == null ? null : json["ingredients_text"],
        ingredientsTextEn: json["ingredients_text_en"] == null
            ? null
            : json["ingredients_text_en"],
        ingredientsTextWithAllergens:
            json["ingredients_text_with_allergens"] == null
                ? null
                : json["ingredients_text_with_allergens"],
        ingredientsTextWithAllergensEn:
            json["ingredients_text_with_allergens_en"] == null
                ? null
                : json["ingredients_text_with_allergens_en"],
        ingredientsThatMayBeFromPalmOilTags:
            json["ingredients_that_may_be_from_palm_oil_tags"] == null
                ? null
                : List<dynamic>.from(
                    json["ingredients_that_may_be_from_palm_oil_tags"]
                            ?.map((x) => x) ??
                        {}),
        interfaceVersionCreated: json["interface_version_created"] == null
            ? null
            : json["interface_version_created"],
        interfaceVersionModified: json["interface_version_modified"] == null
            ? null
            : json["interface_version_modified"],
        labels: json["labels"] == null ? null : json["labels"],
        labelsHierarchy: json["labels_hierarchy"] == null
            ? null
            : List<String>.from(json["labels_hierarchy"]?.map((x) => x) ?? {}),
        labelsLc: json["labels_lc"] == null ? null : json["labels_lc"],
        labelsTags: json["labels_tags"] == null
            ? null
            : List<String>.from(json["labels_tags"]?.map((x) => x) ?? {}),
        lang: json["lang"] == null ? null : json["lang"],
        languages: json["languages"] == null
            ? null
            : Languages().fromJson(json["languages"]),
        languagesCodes: json["languages_codes"] == null
            ? null
            : LanguagesCodes().fromJson(json["languages_codes"]),
        languagesHierarchy: json["languages_hierarchy"] == null
            ? null
            : List<String>.from(
                json["languages_hierarchy"]?.map((x) => x) ?? {}),
        languagesTags: json["languages_tags"] == null
            ? null
            : List<String>.from(json["languages_tags"]?.map((x) => x) ?? {}),
        lastEditDatesTags: json["last_edit_dates_tags"] == null
            ? null
            : List<String>.from(
                json["last_edit_dates_tags"]?.map((x) => x) ?? {}),
        lastEditor: json["last_editor"] == null ? null : json["last_editor"],
        lastImageDatesTags: json["last_image_dates_tags"] == null
            ? null
            : List<String>.from(
                json["last_image_dates_tags"]?.map((x) => x) ?? {}),
        lastImageT: json["last_image_t"] == null ? null : json["last_image_t"],
        lastModifiedBy:
            json["last_modified_by"] == null ? null : json["last_modified_by"],
        lastModifiedT:
            json["last_modified_t"] == null ? null : json["last_modified_t"],
        lc: json["lc"] == null ? null : json["lc"],
        link: json["link"] == null ? null : json["link"],
        mainCountriesTags: json["main_countries_tags"] == null
            ? null
            : List<dynamic>.from(
                json["main_countries_tags"]?.map((x) => x) ?? {}),
        manufacturingPlaces: json["manufacturing_places"] == null
            ? null
            : json["manufacturing_places"],
        manufacturingPlacesTags: json["manufacturing_places_tags"] == null
            ? null
            : List<dynamic>.from(
                json["manufacturing_places_tags"]?.map((x) => x) ?? {}),
        maxImgid: json["max_imgid"] == null ? null : json["max_imgid"],
        mineralsTags: json["minerals_tags"] == null
            ? null
            : List<dynamic>.from(json["minerals_tags"]?.map((x) => x) ?? {}),
        miscTags: json["misc_tags"] == null
            ? null
            : List<String>.from(json["misc_tags"]?.map((x) => x) ?? {}),
        noNutritionData: json["no_nutrition_data"] == null
            ? null
            : json["no_nutrition_data"],
        novaGroupDebug:
            json["nova_group_debug"] == null ? null : json["nova_group_debug"],
        novaGroupTags: json["nova_group_tags"] == null
            ? null
            : List<String>.from(json["nova_group_tags"]?.map((x) => x) ?? {}),
        nucleotidesTags: json["nucleotides_tags"] == null
            ? null
            : List<dynamic>.from(json["nucleotides_tags"]?.map((x) => x) ?? {}),
        nutrientLevels: json["nutrient_levels"] == null
            ? null
            : NutrientLevels().fromJson(json["nutrient_levels"]),
        nutrientLevelsTags: json["nutrient_levels_tags"] == null
            ? null
            : List<String>.from(
                json["nutrient_levels_tags"]?.map((x) => x) ?? {}),
        nutriments: json["nutriments"] == null
            ? null
            : Nutriments().fromJson(json["nutriments"]),
        nutriscoreData: json["nutriscore_data"] == null
            ? null
            : NutriscoreData().fromJson(json["nutriscore_data"]),
        nutriscoreGrade:
            json["nutriscore_grade"] == null ? null : json["nutriscore_grade"],
        nutriscoreScore:
            json["nutriscore_score"] == null ? null : json["nutriscore_score"],
        nutriscoreScoreOpposite: json["nutriscore_score_opposite"] == null
            ? null
            : json["nutriscore_score_opposite"],
        nutritionData:
            json["nutrition_data"] == null ? null : json["nutrition_data"],
        nutritionDataPer: json["nutrition_data_per"] == null
            ? null
            : json["nutrition_data_per"],
        nutritionDataPrepared: json["nutrition_data_prepared"] == null
            ? null
            : json["nutrition_data_prepared"],
        nutritionDataPreparedPer: json["nutrition_data_prepared_per"] == null
            ? null
            : json["nutrition_data_prepared_per"],
        nutritionGradeFr: json["nutrition_grade_fr"] == null
            ? null
            : json["nutrition_grade_fr"],
        nutritionGrades:
            json["nutrition_grades"] == null ? null : json["nutrition_grades"],
        nutritionGradesTags: json["nutrition_grades_tags"] == null
            ? null
            : List<String>.from(
                json["nutrition_grades_tags"]?.map((x) => x) ?? {}),
        nutritionScoreBeverage: json["nutrition_score_beverage"] == null
            ? null
            : json["nutrition_score_beverage"],
        nutritionScoreWarningNoFiber:
            json["nutrition_score_warning_no_fiber"] == null
                ? null
                : json["nutrition_score_warning_no_fiber"],
        nutritionScoreWarningNoFruitsVegetablesNuts:
            json["nutrition_score_warning_no_fruits_vegetables_nuts"] == null
                ? null
                : json["nutrition_score_warning_no_fruits_vegetables_nuts"],
        origins: json["origins"] == null ? null : json["origins"],
        originsHierarchy: json["origins_hierarchy"] == null
            ? null
            : List<dynamic>.from(
                json["origins_hierarchy"]?.map((x) => x) ?? {}),
        originsLc: json["origins_lc"] == null ? null : json["origins_lc"],
        originsTags: json["origins_tags"] == null
            ? null
            : List<dynamic>.from(json["origins_tags"]?.map((x) => x) ?? {}),
        otherNutritionalSubstancesTags:
            json["other_nutritional_substances_tags"] == null
                ? null
                : List<dynamic>.from(
                    json["other_nutritional_substances_tags"]?.map((x) => x) ??
                        {}),
        packaging: json["packaging"] == null ? null : json["packaging"],
        packagingHierarchy: json["packaging_hierarchy"] == null
            ? null
            : List<dynamic>.from(
                json["packaging_hierarchy"]?.map((x) => x) ?? {}),
        packagingLc: json["packaging_lc"] == null ? null : json["packaging_lc"],
        packagingOld:
            json["packaging_old"] == null ? null : json["packaging_old"],
        packagingTags: json["packaging_tags"] == null
            ? null
            : List<dynamic>.from(json["packaging_tags"]?.map((x) => x) ?? {}),
        packagingText:
            json["packaging_text"] == null ? null : json["packaging_text"],
        packagingTextEn: json["packaging_text_en"] == null
            ? null
            : json["packaging_text_en"],
        packagings: json["packagings"] == null
            ? null
            : List<dynamic>.from(json["packagings"]?.map((x) => x) ?? {}),
        photographersTags: json["photographers_tags"] == null
            ? null
            : List<String>.from(
                json["photographers_tags"]?.map((x) => x) ?? {}),
        pnnsGroups1:
            json["pnns_groups_1"] == null ? null : json["pnns_groups_1"],
        pnnsGroups1Tags: json["pnns_groups_1_tags"] == null
            ? null
            : List<String>.from(
                json["pnns_groups_1_tags"]?.map((x) => x) ?? {}),
        pnnsGroups2:
            json["pnns_groups_2"] == null ? null : json["pnns_groups_2"],
        pnnsGroups2Tags: json["pnns_groups_2_tags"] == null
            ? null
            : List<String>.from(
                json["pnns_groups_2_tags"]?.map((x) => x) ?? {}),
        popularityKey:
            json["popularity_key"] == null ? null : json["popularity_key"],
        productName: json["product_name"] == null ? null : json["product_name"],
        productNameEn:
            json["product_name_en"] == null ? null : json["product_name_en"],
        purchasePlaces:
            json["purchase_places"] == null ? null : json["purchase_places"],
        purchasePlacesTags: json["purchase_places_tags"] == null
            ? null
            : List<dynamic>.from(
                json["purchase_places_tags"]?.map((x) => x) ?? {}),
        quantity: json["quantity"] == null ? null : json["quantity"],
        removedCountriesTags: json["removed_countries_tags"] == null
            ? null
            : List<dynamic>.from(
                json["removed_countries_tags"]?.map((x) => x) ?? {}),
        rev: json["rev"] == null ? null : json["rev"],
        selectedImages: json["selected_images"] == null
            ? null
            : SelectedImages().fromJson(json["selected_images"]),
        sortkey: json["sortkey"] == null ? null : json["sortkey"],
        states: json["states"] == null ? null : json["states"],
        statesHierarchy: json["states_hierarchy"] == null
            ? null
            : List<String>.from(json["states_hierarchy"]?.map((x) => x) ?? {}),
        statesTags: json["states_tags"] == null
            ? null
            : List<String>.from(json["states_tags"]?.map((x) => x) ?? {}),
        stores: json["stores"] == null ? null : json["stores"],
        storesTags: json["stores_tags"] == null
            ? null
            : List<String>.from(json["stores_tags"]?.map((x) => x) ?? {}),
        traces: json["traces"] == null ? null : json["traces"],
        tracesFromIngredients: json["traces_from_ingredients"] == null
            ? null
            : json["traces_from_ingredients"],
        tracesFromUser:
            json["traces_from_user"] == null ? null : json["traces_from_user"],
        tracesHierarchy: json["traces_hierarchy"] == null
            ? null
            : List<dynamic>.from(json["traces_hierarchy"]?.map((x) => x) ?? {}),
        tracesLc: json["traces_lc"] == null ? null : json["traces_lc"],
        tracesTags: json["traces_tags"] == null
            ? null
            : List<dynamic>.from(json["traces_tags"]?.map((x) => x) ?? {}),
        unknownNutrientsTags: json["unknown_nutrients_tags"] == null
            ? null
            : List<dynamic>.from(
                json["unknown_nutrients_tags"]?.map((x) => x) ?? {}),
        updateKey: json["update_key"] == null ? null : json["update_key"],
        vitaminsTags: json["vitamins_tags"] == null
            ? null
            : List<dynamic>.from(json["vitamins_tags"]?.map((x) => x) ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "_keywords": keywords == null
            ? null
            : List<dynamic>.from(keywords?.map((x) => x) ?? {}),
        "added_countries_tags": addedCountriesTags == null
            ? null
            : List<dynamic>.from(addedCountriesTags?.map((x) => x) ?? {}),
        "additives_old_tags": additivesOldTags == null
            ? null
            : List<dynamic>.from(additivesOldTags?.map((x) => x) ?? {}),
        "additives_original_tags": additivesOriginalTags == null
            ? null
            : List<dynamic>.from(additivesOriginalTags?.map((x) => x) ?? {}),
        "additives_tags": additivesTags == null
            ? null
            : List<dynamic>.from(additivesTags?.map((x) => x) ?? {}),
        "allergens": allergens == null ? null : allergens,
        "allergens_from_ingredients":
            allergensFromIngredients == null ? null : allergensFromIngredients,
        "allergens_from_user":
            allergensFromUser == null ? null : allergensFromUser,
        "allergens_hierarchy": allergensHierarchy == null
            ? null
            : List<dynamic>.from(allergensHierarchy?.map((x) => x) ?? {}),
        "allergens_lc": allergensLc == null ? null : allergensLc,
        "allergens_tags": allergensTags == null
            ? null
            : List<dynamic>.from(allergensTags?.map((x) => x) ?? {}),
        "amino_acids_tags": aminoAcidsTags == null
            ? null
            : List<dynamic>.from(aminoAcidsTags?.map((x) => x) ?? {}),
        "brands": brands == null ? null : brands,
        "brands_tags": brandsTags == null
            ? null
            : List<dynamic>.from(brandsTags?.map((x) => x) ?? {}),
        "categories": categories == null ? null : categories,
        "categories_hierarchy": categoriesHierarchy == null
            ? null
            : List<dynamic>.from(categoriesHierarchy?.map((x) => x) ?? {}),
        "categories_lc": categoriesLc == null ? null : categoriesLc,
        "categories_old": categoriesOld == null ? null : categoriesOld,
        "categories_properties": categoriesProperties == null
            ? null
            : categoriesProperties?.toJson(),
        "categories_properties_tags": categoriesPropertiesTags == null
            ? null
            : List<dynamic>.from(categoriesPropertiesTags?.map((x) => x) ?? {}),
        "categories_tags": categoriesTags == null
            ? null
            : List<dynamic>.from(categoriesTags?.map((x) => x) ?? {}),
        "checkers_tags": checkersTags == null
            ? null
            : List<dynamic>.from(checkersTags?.map((x) => x) ?? {}),
        "cities_tags": citiesTags == null
            ? null
            : List<dynamic>.from(citiesTags?.map((x) => x) ?? {}),
        "code": code == null ? null : code,
        "codes_tags": codesTags == null
            ? null
            : List<dynamic>.from(codesTags?.map((x) => x) ?? {}),
        "compared_to_category":
            comparedToCategory == null ? null : comparedToCategory,
        "complete": complete == null ? null : complete,
        "completeness": completeness == null ? null : completeness,
        "correctors_tags": correctorsTags == null
            ? null
            : List<dynamic>.from(correctorsTags?.map((x) => x) ?? {}),
        "countries": countries == null ? null : countries,
        "countries_hierarchy": countriesHierarchy == null
            ? null
            : List<dynamic>.from(countriesHierarchy?.map((x) => x) ?? {}),
        "countries_lc": countriesLc == null ? null : countriesLc,
        "countries_tags": countriesTags == null
            ? null
            : List<dynamic>.from(countriesTags?.map((x) => x) ?? {}),
        "created_t": createdT == null ? null : createdT,
        "creator": creator == null ? null : creator,
        "data_quality_bugs_tags": dataQualityBugsTags == null
            ? null
            : List<dynamic>.from(dataQualityBugsTags?.map((x) => x) ?? {}),
        "data_quality_errors_tags": dataQualityErrorsTags == null
            ? null
            : List<dynamic>.from(dataQualityErrorsTags?.map((x) => x) ?? {}),
        "data_quality_info_tags": dataQualityInfoTags == null
            ? null
            : List<dynamic>.from(dataQualityInfoTags?.map((x) => x) ?? {}),
        "data_quality_tags": dataQualityTags == null
            ? null
            : List<dynamic>.from(dataQualityTags?.map((x) => x) ?? {}),
        "data_quality_warnings_tags": dataQualityWarningsTags == null
            ? null
            : List<dynamic>.from(dataQualityWarningsTags?.map((x) => x) ?? {}),
        "data_sources": dataSources == null ? null : dataSources,
        "data_sources_tags": dataSourcesTags == null
            ? null
            : List<dynamic>.from(dataSourcesTags?.map((x) => x) ?? {}),
        "debug_param_sorted_langs": debugParamSortedLangs == null
            ? null
            : List<dynamic>.from(debugParamSortedLangs?.map((x) => x) ?? {}),
        "downgraded": downgraded == null ? null : downgraded,
        "ecoscore_data": ecoscoreData == null ? null : ecoscoreData?.toJson(),
        "ecoscore_grade": ecoscoreGrade == null
            ? null
            : ecoscoreGradeValues.reverse?[ecoscoreGrade],
        "ecoscore_score": ecoscoreScore == null ? null : ecoscoreScore,
        "ecoscore_tags": ecoscoreTags == null
            ? null
            : List<dynamic>.from(
                ecoscoreTags?.map((x) => ecoscoreGradeValues.reverse?[x]) ??
                    {}),
        "editors_tags": editorsTags == null
            ? null
            : List<dynamic>.from(editorsTags?.map((x) => x) ?? {}),
        "emb_codes": embCodes == null ? null : embCodes,
        "emb_codes_tags": embCodesTags == null
            ? null
            : List<dynamic>.from(embCodesTags?.map((x) => x) ?? {}),
        "entry_dates_tags": entryDatesTags == null
            ? null
            : List<dynamic>.from(entryDatesTags?.map((x) => x) ?? {}),
        "expiration_date": expirationDate == null ? null : expirationDate,
        "food_groups": foodGroups == null ? null : foodGroups,
        "food_groups_tags": foodGroupsTags == null
            ? null
            : List<dynamic>.from(foodGroupsTags?.map((x) => x) ?? {}),
        "generic_name": genericName == null ? null : genericName,
        "generic_name_en": genericNameEn == null ? null : genericNameEn,
        "id": productId == null ? null : productId,
        "image_front_small_url":
            imageFrontSmallUrl == null ? null : imageFrontSmallUrl,
        "image_front_thumb_url":
            imageFrontThumbUrl == null ? null : imageFrontThumbUrl,
        "image_front_url": imageFrontUrl == null ? null : imageFrontUrl,
        "image_small_url": imageSmallUrl == null ? null : imageSmallUrl,
        "image_thumb_url": imageThumbUrl == null ? null : imageThumbUrl,
        "image_url": imageUrl == null ? null : imageUrl,
        "images": images == null ? null : images?.toJson(),
        "informers_tags": informersTags == null
            ? null
            : List<dynamic>.from(informersTags?.map((x) => x) ?? {}),
        "ingredients_analysis_tags": ingredientsAnalysisTags == null
            ? null
            : List<dynamic>.from(ingredientsAnalysisTags?.map((x) => x) ?? {}),
        "ingredients_from_palm_oil_tags": ingredientsFromPalmOilTags == null
            ? null
            : List<dynamic>.from(
                ingredientsFromPalmOilTags?.map((x) => x) ?? {}),
        "ingredients_hierarchy": ingredientsHierarchy == null
            ? null
            : List<dynamic>.from(ingredientsHierarchy?.map((x) => x) ?? {}),
        "ingredients_text": ingredientsText == null ? null : ingredientsText,
        "ingredients_text_en":
            ingredientsTextEn == null ? null : ingredientsTextEn,
        "ingredients_text_with_allergens": ingredientsTextWithAllergens == null
            ? null
            : ingredientsTextWithAllergens,
        "ingredients_text_with_allergens_en":
            ingredientsTextWithAllergensEn == null
                ? null
                : ingredientsTextWithAllergensEn,
        "ingredients_that_may_be_from_palm_oil_tags":
            ingredientsThatMayBeFromPalmOilTags == null
                ? null
                : List<dynamic>.from(
                    ingredientsThatMayBeFromPalmOilTags?.map((x) => x) ?? {}),
        "interface_version_created":
            interfaceVersionCreated == null ? null : interfaceVersionCreated,
        "interface_version_modified":
            interfaceVersionModified == null ? null : interfaceVersionModified,
        "labels": labels == null ? null : labels,
        "labels_hierarchy": labelsHierarchy == null
            ? null
            : List<dynamic>.from(labelsHierarchy?.map((x) => x) ?? {}),
        "labels_lc": labelsLc == null ? null : labelsLc,
        "labels_tags": labelsTags == null
            ? null
            : List<dynamic>.from(labelsTags?.map((x) => x) ?? {}),
        "lang": lang == null ? null : lang,
        "languages": languages == null ? null : languages?.toJson(),
        "languages_codes":
            languagesCodes == null ? null : languagesCodes?.toJson(),
        "languages_hierarchy": languagesHierarchy == null
            ? null
            : List<dynamic>.from(languagesHierarchy?.map((x) => x) ?? {}),
        "languages_tags": languagesTags == null
            ? null
            : List<dynamic>.from(languagesTags?.map((x) => x) ?? {}),
        "last_edit_dates_tags": lastEditDatesTags == null
            ? null
            : List<dynamic>.from(lastEditDatesTags?.map((x) => x) ?? {}),
        "last_editor": lastEditor == null ? null : lastEditor,
        "last_image_dates_tags": lastImageDatesTags == null
            ? null
            : List<dynamic>.from(lastImageDatesTags?.map((x) => x) ?? {}),
        "last_image_t": lastImageT == null ? null : lastImageT,
        "last_modified_by": lastModifiedBy == null ? null : lastModifiedBy,
        "last_modified_t": lastModifiedT == null ? null : lastModifiedT,
        "lc": lc == null ? null : lc,
        "link": link == null ? null : link,
        "main_countries_tags": mainCountriesTags == null
            ? null
            : List<dynamic>.from(mainCountriesTags?.map((x) => x) ?? {}),
        "manufacturing_places":
            manufacturingPlaces == null ? null : manufacturingPlaces,
        "manufacturing_places_tags": manufacturingPlacesTags == null
            ? null
            : List<dynamic>.from(manufacturingPlacesTags?.map((x) => x) ?? {}),
        "max_imgid": maxImgid == null ? null : maxImgid,
        "minerals_tags": mineralsTags == null
            ? null
            : List<dynamic>.from(mineralsTags?.map((x) => x) ?? {}),
        "misc_tags": miscTags == null
            ? null
            : List<dynamic>.from(miscTags?.map((x) => x) ?? {}),
        "no_nutrition_data": noNutritionData == null ? null : noNutritionData,
        "nova_group_debug": novaGroupDebug == null ? null : novaGroupDebug,
        "nova_group_tags": novaGroupTags == null
            ? null
            : List<dynamic>.from(novaGroupTags?.map((x) => x) ?? {}),
        "nucleotides_tags": nucleotidesTags == null
            ? null
            : List<dynamic>.from(nucleotidesTags?.map((x) => x) ?? {}),
        "nutrient_levels":
            nutrientLevels == null ? null : nutrientLevels?.toJson(),
        "nutrient_levels_tags": nutrientLevelsTags == null
            ? null
            : List<dynamic>.from(nutrientLevelsTags?.map((x) => x) ?? {}),
        "nutriments": nutriments == null ? null : nutriments?.toJson(),
        "nutriscore_data":
            nutriscoreData == null ? null : nutriscoreData?.toJson(),
        "nutriscore_grade": nutriscoreGrade == null ? null : nutriscoreGrade,
        "nutriscore_score": nutriscoreScore == null ? null : nutriscoreScore,
        "nutriscore_score_opposite":
            nutriscoreScoreOpposite == null ? null : nutriscoreScoreOpposite,
        "nutrition_data": nutritionData == null ? null : nutritionData,
        "nutrition_data_per":
            nutritionDataPer == null ? null : nutritionDataPer,
        "nutrition_data_prepared":
            nutritionDataPrepared == null ? null : nutritionDataPrepared,
        "nutrition_data_prepared_per":
            nutritionDataPreparedPer == null ? null : nutritionDataPreparedPer,
        "nutrition_grade_fr":
            nutritionGradeFr == null ? null : nutritionGradeFr,
        "nutrition_grades": nutritionGrades == null ? null : nutritionGrades,
        "nutrition_grades_tags": nutritionGradesTags == null
            ? null
            : List<dynamic>.from(nutritionGradesTags?.map((x) => x) ?? {}),
        "nutrition_score_beverage":
            nutritionScoreBeverage == null ? null : nutritionScoreBeverage,
        "nutrition_score_warning_no_fiber": nutritionScoreWarningNoFiber == null
            ? null
            : nutritionScoreWarningNoFiber,
        "nutrition_score_warning_no_fruits_vegetables_nuts":
            nutritionScoreWarningNoFruitsVegetablesNuts == null
                ? null
                : nutritionScoreWarningNoFruitsVegetablesNuts,
        "origins": origins == null ? null : origins,
        "origins_hierarchy": originsHierarchy == null
            ? null
            : List<dynamic>.from(originsHierarchy?.map((x) => x) ?? {}),
        "origins_lc": originsLc == null ? null : originsLc,
        "origins_tags": originsTags == null
            ? null
            : List<dynamic>.from(originsTags?.map((x) => x) ?? {}),
        "other_nutritional_substances_tags":
            otherNutritionalSubstancesTags == null
                ? null
                : List<dynamic>.from(
                    otherNutritionalSubstancesTags?.map((x) => x) ?? {}),
        "packaging": packaging == null ? null : packaging,
        "packaging_hierarchy": packagingHierarchy == null
            ? null
            : List<dynamic>.from(packagingHierarchy?.map((x) => x) ?? {}),
        "packaging_lc": packagingLc == null ? null : packagingLc,
        "packaging_old": packagingOld == null ? null : packagingOld,
        "packaging_tags": packagingTags == null
            ? null
            : List<dynamic>.from(packagingTags?.map((x) => x) ?? {}),
        "packaging_text": packagingText == null ? null : packagingText,
        "packaging_text_en": packagingTextEn == null ? null : packagingTextEn,
        "packagings": packagings == null
            ? null
            : List<dynamic>.from(packagings?.map((x) => x) ?? {}),
        "photographers_tags": photographersTags == null
            ? null
            : List<dynamic>.from(photographersTags?.map((x) => x) ?? {}),
        "pnns_groups_1": pnnsGroups1 == null ? null : pnnsGroups1,
        "pnns_groups_1_tags": pnnsGroups1Tags == null
            ? null
            : List<dynamic>.from(pnnsGroups1Tags?.map((x) => x) ?? {}),
        "pnns_groups_2": pnnsGroups2 == null ? null : pnnsGroups2,
        "pnns_groups_2_tags": pnnsGroups2Tags == null
            ? null
            : List<dynamic>.from(pnnsGroups2Tags?.map((x) => x) ?? {}),
        "popularity_key": popularityKey == null ? null : popularityKey,
        "product_name": productName == null ? null : productName,
        "product_name_en": productNameEn == null ? null : productNameEn,
        "purchase_places": purchasePlaces == null ? null : purchasePlaces,
        "purchase_places_tags": purchasePlacesTags == null
            ? null
            : List<dynamic>.from(purchasePlacesTags?.map((x) => x) ?? {}),
        "quantity": quantity == null ? null : quantity,
        "removed_countries_tags": removedCountriesTags == null
            ? null
            : List<dynamic>.from(removedCountriesTags?.map((x) => x) ?? {}),
        "rev": rev == null ? null : rev,
        "selected_images":
            selectedImages == null ? null : selectedImages?.toJson(),
        "sortkey": sortkey == null ? null : sortkey,
        "states": states == null ? null : states,
        "states_hierarchy": statesHierarchy == null
            ? null
            : List<dynamic>.from(statesHierarchy?.map((x) => x) ?? {}),
        "states_tags": statesTags == null
            ? null
            : List<dynamic>.from(statesTags?.map((x) => x) ?? {}),
        "stores": stores == null ? null : stores,
        "stores_tags": storesTags == null
            ? null
            : List<dynamic>.from(storesTags?.map((x) => x) ?? {}),
        "traces": traces == null ? null : traces,
        "traces_from_ingredients":
            tracesFromIngredients == null ? null : tracesFromIngredients,
        "traces_from_user": tracesFromUser == null ? null : tracesFromUser,
        "traces_hierarchy": tracesHierarchy == null
            ? null
            : List<dynamic>.from(tracesHierarchy?.map((x) => x) ?? {}),
        "traces_lc": tracesLc == null ? null : tracesLc,
        "traces_tags": tracesTags == null
            ? null
            : List<dynamic>.from(tracesTags?.map((x) => x) ?? {}),
        "unknown_nutrients_tags": unknownNutrientsTags == null
            ? null
            : List<dynamic>.from(unknownNutrientsTags?.map((x) => x) ?? {}),
        "update_key": updateKey == null ? null : updateKey,
        "vitamins_tags": vitaminsTags == null
            ? null
            : List<dynamic>.from(vitaminsTags?.map((x) => x) ?? {}),
      };
}

class CategoriesProperties {
  CategoriesProperties({
    this.agribalyseFoodCodeEn,
    this.ciqualFoodCodeEn,
  });

  final String? agribalyseFoodCodeEn;
  final String? ciqualFoodCodeEn;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => CategoriesProperties(
        agribalyseFoodCodeEn: json["agribalyse_food_code:en"] == null
            ? null
            : json["agribalyse_food_code:en"],
        ciqualFoodCodeEn: json["ciqual_food_code:en"] == null
            ? null
            : json["ciqual_food_code:en"],
      );

  Map<String, dynamic> toJson() => {
        "agribalyse_food_code:en":
            agribalyseFoodCodeEn == null ? null : agribalyseFoodCodeEn,
        "ciqual_food_code:en":
            ciqualFoodCodeEn == null ? null : ciqualFoodCodeEn,
      };
}

class EcoscoreData {
  EcoscoreData({
    this.adjustments,
    this.agribalyse,
    this.grade,
    this.grades,
    this.missing,
    this.missingDataWarning,
    this.score,
    this.scores,
    this.status,
  });

  final Adjustments? adjustments;
  final Agribalyse? agribalyse;
  final EcoscoreGrade? grade;
  final Map<String, EcoscoreGrade>? grades;
  final Missing? missing;
  final int? missingDataWarning;
  final int? score;
  final Map<String, int>? scores;
  final String? status;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => EcoscoreData(
        adjustments: json["adjustments"] == null
            ? null
            : Adjustments().fromJson(json["adjustments"]),
        agribalyse: json["agribalyse"] == null
            ? null
            : Agribalyse().fromJson(json["agribalyse"]),
        grade: json["grade"] == null
            ? null
            : ecoscoreGradeValues.map[json["grade"]],
        grades: json["grades"] == null
            ? null
            : Map.from(json["grades"]).map((k, v) =>
                MapEntry<String, EcoscoreGrade>(
                    k, ecoscoreGradeValues.map[v] ?? EcoscoreGrade.B)),
        missing: json["missing"] == null
            ? null
            : Missing().fromJson(json["missing"]),
        missingDataWarning: json["missing_data_warning"] == null
            ? null
            : json["missing_data_warning"],
        score: json["score"] == null ? null : json["score"],
        scores: json["scores"] == null
            ? null
            : Map.from(json["scores"])
                .map((k, v) => MapEntry<String, int>(k, v)),
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "adjustments": adjustments == null ? null : adjustments?.toJson(),
        "agribalyse": agribalyse == null ? null : agribalyse?.toJson(),
        "grade": grade == null ? null : ecoscoreGradeValues.reverse?[grade],
        "grades": grades == null
            ? null
            : Map.from(grades ?? {}).map((k, v) =>
                MapEntry<String, dynamic>(k, ecoscoreGradeValues.reverse?[v])),
        "missing": missing == null ? null : missing?.toJson(),
        "missing_data_warning":
            missingDataWarning == null ? null : missingDataWarning,
        "score": score == null ? null : score,
        "scores": scores == null
            ? null
            : Map.from(scores ?? {})
                .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "status": status == null ? null : status,
      };
}

class Adjustments {
  Adjustments({
    this.originsOfIngredients,
    this.packaging,
    this.productionSystem,
    this.threatenedSpecies,
  });

  final OriginsOfIngredients? originsOfIngredients;
  final Packaging? packaging;
  final ProductionSystem? productionSystem;
  final ThreatenedSpecies? threatenedSpecies;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => Adjustments(
        originsOfIngredients: json["origins_of_ingredients"] == null
            ? null
            : OriginsOfIngredients().fromJson(json["origins_of_ingredients"]),
        packaging: json["packaging"] == null
            ? null
            : Packaging().fromJson(json["packaging"]),
        productionSystem: json["production_system"] == null
            ? null
            : ProductionSystem().fromJson(json["production_system"]),
        threatenedSpecies: json["threatened_species"] == null
            ? null
            : ThreatenedSpecies().fromJson(json["threatened_species"]),
      );

  Map<String, dynamic> toJson() => {
        "origins_of_ingredients": originsOfIngredients == null
            ? null
            : originsOfIngredients?.toJson(),
        "packaging": packaging == null ? null : packaging?.toJson(),
        "production_system":
            productionSystem == null ? null : productionSystem?.toJson(),
        "threatened_species":
            threatenedSpecies == null ? null : threatenedSpecies?.toJson(),
      };
}

class OriginsOfIngredients {
  OriginsOfIngredients({
    this.aggregatedOrigins,
    this.epiScore,
    this.epiValue,
    this.originsFromOriginsField,
    this.transportationScores,
    this.transportationValues,
    this.values,
    this.warning,
  });

  final List<AggregatedOrigin>? aggregatedOrigins;
  final int? epiScore;
  final int? epiValue;
  final List<String>? originsFromOriginsField;
  final Map<String, int>? transportationScores;
  final Map<String, int>? transportationValues;
  final Map<String, int>? values;
  final String? warning;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => OriginsOfIngredients(
        aggregatedOrigins: json["aggregated_origins"] == null
            ? null
            : List<AggregatedOrigin>.from(json["aggregated_origins"]
                .map((x) => AggregatedOrigin().fromJson(x))),
        epiScore: json["epi_score"] == null ? null : json["epi_score"],
        epiValue: json["epi_value"] == null ? null : json["epi_value"],
        originsFromOriginsField: json["origins_from_origins_field"] == null
            ? null
            : List<String>.from(
                json["origins_from_origins_field"]?.map((x) => x) ?? {}),
        transportationScores: json["transportation_scores"] == null
            ? null
            : Map.from(json["transportation_scores"])
                .map((k, v) => MapEntry<String, int>(k, v)),
        transportationValues: json["transportation_values"] == null
            ? null
            : Map.from(json["transportation_values"])
                .map((k, v) => MapEntry<String, int>(k, v)),
        values: json["values"] == null
            ? null
            : Map.from(json["values"])
                .map((k, v) => MapEntry<String, int>(k, v)),
        warning: json["warning"] == null ? null : json["warning"],
      );

  Map<String, dynamic> toJson() => {
        "aggregated_origins": aggregatedOrigins == null
            ? null
            : List<dynamic>.from(
                aggregatedOrigins?.map((x) => x.toJson()) ?? {}),
        "epi_score": epiScore == null ? null : epiScore,
        "epi_value": epiValue == null ? null : epiValue,
        "origins_from_origins_field": originsFromOriginsField == null
            ? null
            : List<dynamic>.from(originsFromOriginsField?.map((x) => x) ?? {}),
        "transportation_scores": transportationScores == null
            ? null
            : Map.from(transportationScores ?? {})
                .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "transportation_values": transportationValues == null
            ? null
            : Map.from(transportationValues ?? {})
                .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "values": values == null
            ? null
            : Map.from(values ?? {})
                .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "warning": warning == null ? null : warning,
      };
}

class AggregatedOrigin {
  AggregatedOrigin({
    this.origin,
    this.percent,
  });

  final String? origin;
  final int? percent;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => AggregatedOrigin(
        origin: json["origin"] == null ? null : json["origin"],
        percent: json["percent"] == null ? null : json["percent"],
      );

  Map<String, dynamic> toJson() => {
        "origin": origin == null ? null : origin,
        "percent": percent == null ? null : percent,
      };
}

class Packaging {
  Packaging({
    this.nonRecyclableAndNonBiodegradableMaterials,
    this.value,
    this.warning,
  });

  final int? nonRecyclableAndNonBiodegradableMaterials;
  final int? value;
  final String? warning;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => Packaging(
        nonRecyclableAndNonBiodegradableMaterials:
            json["non_recyclable_and_non_biodegradable_materials"] == null
                ? null
                : json["non_recyclable_and_non_biodegradable_materials"],
        value: json["value"] == null ? null : json["value"],
        warning: json["warning"] == null ? null : json["warning"],
      );

  Map<String, dynamic> toJson() => {
        "non_recyclable_and_non_biodegradable_materials":
            nonRecyclableAndNonBiodegradableMaterials == null
                ? null
                : nonRecyclableAndNonBiodegradableMaterials,
        "value": value == null ? null : value,
        "warning": warning == null ? null : warning,
      };
}

class ProductionSystem {
  ProductionSystem({
    this.labels,
    this.value,
    this.warning,
  });

  final List<dynamic>? labels;
  final int? value;
  final String? warning;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => ProductionSystem(
        labels: json["labels"] == null
            ? null
            : List<dynamic>.from(json["labels"]?.map((x) => x) ?? {}),
        value: json["value"] == null ? null : json["value"],
        warning: json["warning"] == null ? null : json["warning"],
      );

  Map<String, dynamic> toJson() => {
        "labels": labels == null
            ? null
            : List<dynamic>.from(labels?.map((x) => x) ?? {}),
        "value": value == null ? null : value,
        "warning": warning == null ? null : warning,
      };
}

class ThreatenedSpecies {
  ThreatenedSpecies({
    this.warning,
  });

  final String? warning;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => ThreatenedSpecies(
        warning: json["warning"] == null ? null : json["warning"],
      );

  Map<String, dynamic> toJson() => {
        "warning": warning == null ? null : warning,
      };
}

class Agribalyse {
  Agribalyse({
    this.agribalyseFoodCode,
    this.co2Agriculture,
    this.co2Consumption,
    this.co2Distribution,
    this.co2Packaging,
    this.co2Processing,
    this.co2Total,
    this.co2Transportation,
    this.code,
    this.dqr,
    this.efAgriculture,
    this.efConsumption,
    this.efDistribution,
    this.efPackaging,
    this.efProcessing,
    this.efTotal,
    this.efTransportation,
    this.isBeverage,
    this.nameEn,
    this.nameFr,
    this.score,
  });

  final String? agribalyseFoodCode;
  final double? co2Agriculture;
  final double? co2Consumption;
  final double? co2Distribution;
  final double? co2Packaging;
  final double? co2Processing;
  final double? co2Total;
  final double? co2Transportation;
  final String? code;
  final String? dqr;
  final double? efAgriculture;
  final double? efConsumption;
  final double? efDistribution;
  final double? efPackaging;
  final double? efProcessing;
  final double? efTotal;
  final double? efTransportation;
  final int? isBeverage;
  final String? nameEn;
  final String? nameFr;
  final int? score;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => Agribalyse(
        agribalyseFoodCode: json["agribalyse_food_code"] == null
            ? null
            : json["agribalyse_food_code"],
        co2Agriculture: json["co2_agriculture"] == null
            ? null
            : json["co2_agriculture"].toDouble(),
        co2Consumption: json["co2_consumption"] == null
            ? null
            : json["co2_consumption"].toDouble(),
        co2Distribution: json["co2_distribution"] == null
            ? null
            : json["co2_distribution"].toDouble(),
        co2Packaging: json["co2_packaging"] == null
            ? null
            : json["co2_packaging"].toDouble(),
        co2Processing: json["co2_processing"] == null
            ? null
            : json["co2_processing"].toDouble(),
        co2Total:
            json["co2_total"] == null ? null : json["co2_total"].toDouble(),
        co2Transportation: json["co2_transportation"] == null
            ? null
            : json["co2_transportation"].toDouble(),
        code: json["code"] == null ? null : json["code"],
        dqr: json["dqr"] == null ? null : json["dqr"],
        efAgriculture: json["ef_agriculture"] == null
            ? null
            : json["ef_agriculture"].toDouble(),
        efConsumption: json["ef_consumption"] == null
            ? null
            : json["ef_consumption"].toDouble(),
        efDistribution: json["ef_distribution"] == null
            ? null
            : json["ef_distribution"].toDouble(),
        efPackaging: json["ef_packaging"] == null
            ? null
            : json["ef_packaging"].toDouble(),
        efProcessing: json["ef_processing"] == null
            ? null
            : json["ef_processing"].toDouble(),
        efTotal: json["ef_total"] == null ? null : json["ef_total"].toDouble(),
        efTransportation: json["ef_transportation"] == null
            ? null
            : json["ef_transportation"].toDouble(),
        isBeverage: json["is_beverage"] == null ? null : json["is_beverage"],
        nameEn: json["name_en"] == null ? null : json["name_en"],
        nameFr: json["name_fr"] == null ? null : json["name_fr"],
        score: json["score"] == null ? null : json["score"],
      );

  Map<String, dynamic> toJson() => {
        "agribalyse_food_code":
            agribalyseFoodCode == null ? null : agribalyseFoodCode,
        "co2_agriculture": co2Agriculture == null ? null : co2Agriculture,
        "co2_consumption": co2Consumption == null ? null : co2Consumption,
        "co2_distribution": co2Distribution == null ? null : co2Distribution,
        "co2_packaging": co2Packaging == null ? null : co2Packaging,
        "co2_processing": co2Processing == null ? null : co2Processing,
        "co2_total": co2Total == null ? null : co2Total,
        "co2_transportation":
            co2Transportation == null ? null : co2Transportation,
        "code": code == null ? null : code,
        "dqr": dqr == null ? null : dqr,
        "ef_agriculture": efAgriculture == null ? null : efAgriculture,
        "ef_consumption": efConsumption == null ? null : efConsumption,
        "ef_distribution": efDistribution == null ? null : efDistribution,
        "ef_packaging": efPackaging == null ? null : efPackaging,
        "ef_processing": efProcessing == null ? null : efProcessing,
        "ef_total": efTotal == null ? null : efTotal,
        "ef_transportation": efTransportation == null ? null : efTransportation,
        "is_beverage": isBeverage == null ? null : isBeverage,
        "name_en": nameEn == null ? null : nameEn,
        "name_fr": nameFr == null ? null : nameFr,
        "score": score == null ? null : score,
      };
}

enum EcoscoreGrade { A, B, C, D, E, F, G, UNKNOWN }

final ecoscoreGradeValues = EnumValues({
  "a": EcoscoreGrade.A,
  "b": EcoscoreGrade.B,
  "c": EcoscoreGrade.C,
  "d": EcoscoreGrade.D,
  "e": EcoscoreGrade.E,
  "f": EcoscoreGrade.F,
  "g": EcoscoreGrade.G,
  "unknown": EcoscoreGrade.UNKNOWN,
});

class Missing {
  Missing({
    this.ingredients,
    this.labels,
    this.origins,
    this.packagings,
  });

  final int? ingredients;
  final int? labels;
  final int? origins;
  final int? packagings;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => Missing(
        ingredients: json["ingredients"] == null ? null : json["ingredients"],
        labels: json["labels"] == null ? null : json["labels"],
        origins: json["origins"] == null ? null : json["origins"],
        packagings: json["packagings"] == null ? null : json["packagings"],
      );

  Map<String, dynamic> toJson() => {
        "ingredients": ingredients == null ? null : ingredients,
        "labels": labels == null ? null : labels,
        "origins": origins == null ? null : origins,
        "packagings": packagings == null ? null : packagings,
      };
}

class Images {
  Images({
    this.the1,
    this.frontEn,
  });

  final The1? the1;
  final FrontEn? frontEn;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => Images(
        the1: json["1"] == null ? null : The1().fromJson(json["1"]),
        frontEn: json["front_en"] == null
            ? null
            : FrontEn().fromJson(json["front_en"]),
      );

  Map<String, dynamic> toJson() => {
        "1": the1 == null ? null : the1?.toJson(),
        "front_en": frontEn == null ? null : frontEn?.toJson(),
      };
}

class FrontEn {
  FrontEn({
    this.angle,
    this.geometry,
    this.imgid,
    this.normalize,
    this.rev,
    this.sizes,
    this.whiteMagic,
    this.x1,
    this.x2,
    this.y1,
    this.y2,
  });

  final int? angle;
  final String? geometry;
  final String? imgid;
  final dynamic normalize;
  final String? rev;
  final Sizes? sizes;
  final dynamic whiteMagic;
  final dynamic x1;
  final dynamic x2;
  final dynamic y1;
  final dynamic y2;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => FrontEn(
        angle: json["angle"] == null ? null : json["angle"],
        geometry: json["geometry"] == null ? null : json["geometry"],
        imgid: json["imgid"] == null ? null : json["imgid"],
        normalize: json["normalize"],
        rev: json["rev"] == null ? null : json["rev"],
        sizes: json["sizes"] == null ? null : Sizes().fromJson(json["sizes"]),
        whiteMagic: json["white_magic"],
        x1: json["x1"] == null ? null : json["x1"],
        x2: json["x2"] == null ? null : json["x2"],
        y1: json["y1"] == null ? null : json["y1"],
        y2: json["y2"] == null ? null : json["y2"],
      );

  Map<String, dynamic> toJson() => {
        "angle": angle == null ? null : angle,
        "geometry": geometry == null ? null : geometry,
        "imgid": imgid == null ? null : imgid,
        "normalize": normalize,
        "rev": rev == null ? null : rev,
        "sizes": sizes == null ? null : sizes?.toJson(),
        "white_magic": whiteMagic,
        "x1": x1 == null ? null : x1,
        "x2": x2 == null ? null : x2,
        "y1": y1 == null ? null : y1,
        "y2": y2 == null ? null : y2,
      };
}

class Sizes {
  Sizes({
    this.the100,
    this.the400,
    this.full,
    this.the200,
  });

  final The100? the100;
  final The100? the400;
  final The100? full;
  final The100? the200;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => Sizes(
        the100: json["100"] == null ? null : The100().fromJson(json["100"]),
        the400: json["400"] == null ? null : The100().fromJson(json["400"]),
        full: json["full"] == null ? null : The100().fromJson(json["full"]),
        the200: json["200"] == null ? null : The100().fromJson(json["200"]),
      );

  Map<String, dynamic> toJson() => {
        "100": the100 == null ? null : the100?.toJson(),
        "400": the400 == null ? null : the400?.toJson(),
        "full": full == null ? null : full?.toJson(),
        "200": the200 == null ? null : the200?.toJson(),
      };
}

class The100 {
  The100({
    this.h,
    this.w,
  });

  final int? h;
  final int? w;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => The100(
        h: json["h"] == null ? null : json["h"],
        w: json["w"] == null ? null : json["w"],
      );

  Map<String, dynamic> toJson() => {
        "h": h == null ? null : h,
        "w": w == null ? null : w,
      };
}

class The1 {
  The1({
    this.sizes,
    this.uploadedT,
    this.uploader,
  });

  final Sizes? sizes;
  final dynamic uploadedT;
  final String? uploader;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => The1(
        sizes: json["sizes"] == null ? null : Sizes().fromJson(json["sizes"]),
        uploadedT: json["uploaded_t"] == null ? null : json["uploaded_t"],
        uploader: json["uploader"] == null ? null : json["uploader"],
      );

  Map<String, dynamic> toJson() => {
        "sizes": sizes == null ? null : sizes?.toJson(),
        "uploaded_t": uploadedT == null ? null : uploadedT,
        "uploader": uploader == null ? null : uploader,
      };
}

class Languages {
  Languages({
    this.enEnglish,
  });

  final int? enEnglish;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => Languages(
        enEnglish: json["en:english"] == null ? null : json["en:english"],
      );

  Map<String, dynamic> toJson() => {
        "en:english": enEnglish == null ? null : enEnglish,
      };
}

class LanguagesCodes {
  LanguagesCodes({
    this.en,
  });

  final int? en;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => LanguagesCodes(
        en: json["en"] == null ? null : json["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en == null ? null : en,
      };
}

class NutrientLevels {
  NutrientLevels({
    this.fat,
    this.salt,
    this.saturatedFat,
    this.sugars,
  });

  final String? fat;
  final String? salt;
  final String? saturatedFat;
  final String? sugars;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => NutrientLevels(
        fat: json["fat"] == null ? null : json["fat"],
        salt: json["salt"] == null ? null : json["salt"],
        saturatedFat:
            json["saturated-fat"] == null ? null : json["saturated-fat"],
        sugars: json["sugars"] == null ? null : json["sugars"],
      );

  Map<String, dynamic> toJson() => {
        "fat": fat == null ? null : fat,
        "salt": salt == null ? null : salt,
        "saturated-fat": saturatedFat == null ? null : saturatedFat,
        "sugars": sugars == null ? null : sugars,
      };
}

class Nutriments {
  Nutriments({
    this.carbohydrates,
    this.carbohydrates100G,
    this.carbohydratesUnit,
    this.carbohydratesValue,
    this.energy,
    this.energyKcal,
    this.energyKcal100G,
    this.energyKcalUnit,
    this.energyKcalValue,
    this.energy100G,
    this.energyUnit,
    this.energyValue,
    this.fat,
    this.fat100G,
    this.fatUnit,
    this.fatValue,
    this.nutritionScoreFr,
    this.nutritionScoreFr100G,
    this.proteins,
    this.proteins100G,
    this.proteinsUnit,
    this.proteinsValue,
    this.salt,
    this.salt100G,
    this.saltUnit,
    this.saltValue,
    this.saturatedFat,
    this.saturatedFat100G,
    this.saturatedFatUnit,
    this.saturatedFatValue,
    this.sodium,
    this.sodium100G,
    this.sodiumUnit,
    this.sodiumValue,
    this.sugars,
    this.sugars100G,
    this.sugarsUnit,
    this.sugarsValue,
  });

  final num? carbohydrates;
  final num? carbohydrates100G;
  final String? carbohydratesUnit;
  final num? carbohydratesValue;
  final num? energy;
  final num? energyKcal;
  final num? energyKcal100G;
  final String? energyKcalUnit;
  final num? energyKcalValue;
  final num? energy100G;
  final String? energyUnit;
  final num? energyValue;
  final num? fat;
  final num? fat100G;
  final String? fatUnit;
  final num? fatValue;
  final num? nutritionScoreFr;
  final num? nutritionScoreFr100G;
  final num? proteins;
  final num? proteins100G;
  final String? proteinsUnit;
  final num? proteinsValue;
  final num? salt;
  final num? salt100G;
  final String? saltUnit;
  final num? saltValue;
  final num? saturatedFat;
  final num? saturatedFat100G;
  final String? saturatedFatUnit;
  final num? saturatedFatValue;
  final num? sodium;
  final num? sodium100G;
  final String? sodiumUnit;
  final num? sodiumValue;
  final num? sugars;
  final num? sugars100G;
  final String? sugarsUnit;
  final num? sugarsValue;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => Nutriments(
        carbohydrates:
            json["carbohydrates"] == null ? null : json["carbohydrates"],
        carbohydrates100G: json["carbohydrates_100g"] == null
            ? null
            : json["carbohydrates_100g"],
        carbohydratesUnit: json["carbohydrates_unit"] == null
            ? null
            : json["carbohydrates_unit"],
        carbohydratesValue: json["carbohydrates_value"] == null
            ? null
            : json["carbohydrates_value"],
        energy: json["energy"] == null ? null : json["energy"],
        energyKcal: json["energy-kcal"] == null ? null : json["energy-kcal"],
        energyKcal100G:
            json["energy-kcal_100g"] == null ? null : json["energy-kcal_100g"],
        energyKcalUnit:
            json["energy-kcal_unit"] == null ? null : json["energy-kcal_unit"],
        energyKcalValue: json["energy-kcal_value"] == null
            ? null
            : json["energy-kcal_value"],
        energy100G: json["energy_100g"] == null ? null : json["energy_100g"],
        energyUnit: json["energy_unit"] == null ? null : json["energy_unit"],
        energyValue: json["energy_value"] == null ? null : json["energy_value"],
        fat: json["fat"] == null ? null : json["fat"].toDouble(),
        fat100G: json["fat_100g"] == null ? null : json["fat_100g"].toDouble(),
        fatUnit: json["fat_unit"] == null ? null : json["fat_unit"],
        fatValue:
            json["fat_value"] == null ? null : json["fat_value"].toDouble(),
        nutritionScoreFr: json["nutrition-score-fr"] == null
            ? null
            : json["nutrition-score-fr"],
        nutritionScoreFr100G: json["nutrition-score-fr_100g"] == null
            ? null
            : json["nutrition-score-fr_100g"],
        proteins: json["proteins"] == null ? null : json["proteins"].toDouble(),
        proteins100G: json["proteins_100g"] == null
            ? null
            : json["proteins_100g"].toDouble(),
        proteinsUnit:
            json["proteins_unit"] == null ? null : json["proteins_unit"],
        proteinsValue: json["proteins_value"] == null
            ? null
            : json["proteins_value"].toDouble(),
        salt: json["salt"] == null ? null : json["salt"].toDouble(),
        salt100G:
            json["salt_100g"] == null ? null : json["salt_100g"].toDouble(),
        saltUnit: json["salt_unit"] == null ? null : json["salt_unit"],
        saltValue:
            json["salt_value"] == null ? null : json["salt_value"].toDouble(),
        saturatedFat: json["saturated-fat"] == null
            ? null
            : json["saturated-fat"].toDouble(),
        saturatedFat100G: json["saturated-fat_100g"] == null
            ? null
            : json["saturated-fat_100g"].toDouble(),
        saturatedFatUnit: json["saturated-fat_unit"] == null
            ? null
            : json["saturated-fat_unit"],
        saturatedFatValue: json["saturated-fat_value"] == null
            ? null
            : json["saturated-fat_value"].toDouble(),
        sodium: json["sodium"] == null ? null : json["sodium"].toDouble(),
        sodium100G:
            json["sodium_100g"] == null ? null : json["sodium_100g"].toDouble(),
        sodiumUnit: json["sodium_unit"] == null ? null : json["sodium_unit"],
        sodiumValue: json["sodium_value"] == null
            ? null
            : json["sodium_value"].toDouble(),
        sugars: json["sugars"] == null ? null : json["sugars"],
        sugars100G: json["sugars_100g"] == null ? null : json["sugars_100g"],
        sugarsUnit: json["sugars_unit"] == null ? null : json["sugars_unit"],
        sugarsValue: json["sugars_value"] == null ? null : json["sugars_value"],
      );

  Map<String, dynamic> toJson() => {
        "carbohydrates": carbohydrates == null ? null : carbohydrates,
        "carbohydrates_100g":
            carbohydrates100G == null ? null : carbohydrates100G,
        "carbohydrates_unit":
            carbohydratesUnit == null ? null : carbohydratesUnit,
        "carbohydrates_value":
            carbohydratesValue == null ? null : carbohydratesValue,
        "energy": energy == null ? null : energy,
        "energy-kcal": energyKcal == null ? null : energyKcal,
        "energy-kcal_100g": energyKcal100G == null ? null : energyKcal100G,
        "energy-kcal_unit": energyKcalUnit == null ? null : energyKcalUnit,
        "energy-kcal_value": energyKcalValue == null ? null : energyKcalValue,
        "energy_100g": energy100G == null ? null : energy100G,
        "energy_unit": energyUnit == null ? null : energyUnit,
        "energy_value": energyValue == null ? null : energyValue,
        "fat": fat == null ? null : fat,
        "fat_100g": fat100G == null ? null : fat100G,
        "fat_unit": fatUnit == null ? null : fatUnit,
        "fat_value": fatValue == null ? null : fatValue,
        "nutrition-score-fr":
            nutritionScoreFr == null ? null : nutritionScoreFr,
        "nutrition-score-fr_100g":
            nutritionScoreFr100G == null ? null : nutritionScoreFr100G,
        "proteins": proteins == null ? null : proteins,
        "proteins_100g": proteins100G == null ? null : proteins100G,
        "proteins_unit": proteinsUnit == null ? null : proteinsUnit,
        "proteins_value": proteinsValue == null ? null : proteinsValue,
        "salt": salt == null ? null : salt,
        "salt_100g": salt100G == null ? null : salt100G,
        "salt_unit": saltUnit == null ? null : saltUnit,
        "salt_value": saltValue == null ? null : saltValue,
        "saturated-fat": saturatedFat == null ? null : saturatedFat,
        "saturated-fat_100g":
            saturatedFat100G == null ? null : saturatedFat100G,
        "saturated-fat_unit":
            saturatedFatUnit == null ? null : saturatedFatUnit,
        "saturated-fat_value":
            saturatedFatValue == null ? null : saturatedFatValue,
        "sodium": sodium == null ? null : sodium,
        "sodium_100g": sodium100G == null ? null : sodium100G,
        "sodium_unit": sodiumUnit == null ? null : sodiumUnit,
        "sodium_value": sodiumValue == null ? null : sodiumValue,
        "sugars": sugars == null ? null : sugars,
        "sugars_100g": sugars100G == null ? null : sugars100G,
        "sugars_unit": sugarsUnit == null ? null : sugarsUnit,
        "sugars_value": sugarsValue == null ? null : sugarsValue,
      };
}

class NutriscoreData {
  NutriscoreData({
    this.energy,
    this.energyPoints,
    this.energyValue,
    this.fiber,
    this.fiberPoints,
    this.fiberValue,
    this.fruitsVegetablesNutsColzaWalnutOliveOils,
    this.fruitsVegetablesNutsColzaWalnutOliveOilsPoints,
    this.fruitsVegetablesNutsColzaWalnutOliveOilsValue,
    this.grade,
    this.isBeverage,
    this.isCheese,
    this.isFat,
    this.isWater,
    this.negativePoints,
    this.positivePoints,
    this.proteins,
    this.proteinsPoints,
    this.proteinsValue,
    this.saturatedFat,
    this.saturatedFatPoints,
    this.saturatedFatRatio,
    this.saturatedFatRatioPoints,
    this.saturatedFatRatioValue,
    this.saturatedFatValue,
    this.score,
    this.sodium,
    this.sodiumPoints,
    this.sodiumValue,
    this.sugars,
    this.sugarsPoints,
    this.sugarsValue,
  });

  final num? energy;
  final num? energyPoints;
  final num? energyValue;
  final num? fiber;
  final num? fiberPoints;
  final num? fiberValue;
  final num? fruitsVegetablesNutsColzaWalnutOliveOils;
  final num? fruitsVegetablesNutsColzaWalnutOliveOilsPoints;
  final num? fruitsVegetablesNutsColzaWalnutOliveOilsValue;
  final String? grade;
  final num? isBeverage;
  final num? isCheese;
  final num? isFat;
  final num? isWater;
  final num? negativePoints;
  final num? positivePoints;
  final double? proteins;
  final num? proteinsPoints;
  final double? proteinsValue;
  final double? saturatedFat;
  final num? saturatedFatPoints;
  final num? saturatedFatRatio;
  final num? saturatedFatRatioPoints;
  final num? saturatedFatRatioValue;
  final double? saturatedFatValue;
  final num? score;
  final num? sodium;
  final num? sodiumPoints;
  final num? sodiumValue;
  final num? sugars;
  final num? sugarsPoints;
  final num? sugarsValue;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => NutriscoreData(
        energy: json["energy"] == null ? null : json["energy"],
        energyPoints:
            json["energy_points"] == null ? null : json["energy_points"],
        energyValue: json["energy_value"] == null ? null : json["energy_value"],
        fiber: json["fiber"] == null ? null : json["fiber"],
        fiberPoints: json["fiber_points"] == null ? null : json["fiber_points"],
        fiberValue: json["fiber_value"] == null ? null : json["fiber_value"],
        fruitsVegetablesNutsColzaWalnutOliveOils:
            json["fruits_vegetables_nuts_colza_walnut_olive_oils"] == null
                ? null
                : json["fruits_vegetables_nuts_colza_walnut_olive_oils"],
        fruitsVegetablesNutsColzaWalnutOliveOilsPoints:
            json["fruits_vegetables_nuts_colza_walnut_olive_oils_points"] ==
                    null
                ? null
                : json["fruits_vegetables_nuts_colza_walnut_olive_oils_points"],
        fruitsVegetablesNutsColzaWalnutOliveOilsValue:
            json["fruits_vegetables_nuts_colza_walnut_olive_oils_value"] == null
                ? null
                : json["fruits_vegetables_nuts_colza_walnut_olive_oils_value"],
        grade: json["grade"] == null ? null : json["grade"],
        isBeverage: json["is_beverage"] == null ? null : json["is_beverage"],
        isCheese: json["is_cheese"] == null ? null : json["is_cheese"],
        isFat: json["is_fat"] == null ? null : json["is_fat"],
        isWater: json["is_water"] == null ? null : json["is_water"],
        negativePoints:
            json["negative_points"] == null ? null : json["negative_points"],
        positivePoints:
            json["positive_points"] == null ? null : json["positive_points"],
        proteins: json["proteins"] == null ? null : json["proteins"].toDouble(),
        proteinsPoints:
            json["proteins_points"] == null ? null : json["proteins_points"],
        proteinsValue: json["proteins_value"] == null
            ? null
            : json["proteins_value"].toDouble(),
        saturatedFat: json["saturated_fat"] == null
            ? null
            : json["saturated_fat"].toDouble(),
        saturatedFatPoints: json["saturated_fat_points"] == null
            ? null
            : json["saturated_fat_points"],
        saturatedFatRatio: json["saturated_fat_ratio"] == null
            ? null
            : json["saturated_fat_ratio"],
        saturatedFatRatioPoints: json["saturated_fat_ratio_points"] == null
            ? null
            : json["saturated_fat_ratio_points"],
        saturatedFatRatioValue: json["saturated_fat_ratio_value"] == null
            ? null
            : json["saturated_fat_ratio_value"],
        saturatedFatValue: json["saturated_fat_value"] == null
            ? null
            : json["saturated_fat_value"].toDouble(),
        score: json["score"] == null ? null : json["score"],
        sodium: json["sodium"] == null ? null : json["sodium"],
        sodiumPoints:
            json["sodium_points"] == null ? null : json["sodium_points"],
        sodiumValue: json["sodium_value"] == null ? null : json["sodium_value"],
        sugars: json["sugars"] == null ? null : json["sugars"],
        sugarsPoints:
            json["sugars_points"] == null ? null : json["sugars_points"],
        sugarsValue: json["sugars_value"] == null ? null : json["sugars_value"],
      );

  Map<String, dynamic> toJson() => {
        "energy": energy == null ? null : energy,
        "energy_points": energyPoints == null ? null : energyPoints,
        "energy_value": energyValue == null ? null : energyValue,
        "fiber": fiber == null ? null : fiber,
        "fiber_points": fiberPoints == null ? null : fiberPoints,
        "fiber_value": fiberValue == null ? null : fiberValue,
        "fruits_vegetables_nuts_colza_walnut_olive_oils":
            fruitsVegetablesNutsColzaWalnutOliveOils == null
                ? null
                : fruitsVegetablesNutsColzaWalnutOliveOils,
        "fruits_vegetables_nuts_colza_walnut_olive_oils_points":
            fruitsVegetablesNutsColzaWalnutOliveOilsPoints == null
                ? null
                : fruitsVegetablesNutsColzaWalnutOliveOilsPoints,
        "fruits_vegetables_nuts_colza_walnut_olive_oils_value":
            fruitsVegetablesNutsColzaWalnutOliveOilsValue == null
                ? null
                : fruitsVegetablesNutsColzaWalnutOliveOilsValue,
        "grade": grade == null ? null : grade,
        "is_beverage": isBeverage == null ? null : isBeverage,
        "is_cheese": isCheese == null ? null : isCheese,
        "is_fat": isFat == null ? null : isFat,
        "is_water": isWater == null ? null : isWater,
        "negative_points": negativePoints == null ? null : negativePoints,
        "positive_points": positivePoints == null ? null : positivePoints,
        "proteins": proteins == null ? null : proteins,
        "proteins_points": proteinsPoints == null ? null : proteinsPoints,
        "proteins_value": proteinsValue == null ? null : proteinsValue,
        "saturated_fat": saturatedFat == null ? null : saturatedFat,
        "saturated_fat_points":
            saturatedFatPoints == null ? null : saturatedFatPoints,
        "saturated_fat_ratio":
            saturatedFatRatio == null ? null : saturatedFatRatio,
        "saturated_fat_ratio_points":
            saturatedFatRatioPoints == null ? null : saturatedFatRatioPoints,
        "saturated_fat_ratio_value":
            saturatedFatRatioValue == null ? null : saturatedFatRatioValue,
        "saturated_fat_value":
            saturatedFatValue == null ? null : saturatedFatValue,
        "score": score == null ? null : score,
        "sodium": sodium == null ? null : sodium,
        "sodium_points": sodiumPoints == null ? null : sodiumPoints,
        "sodium_value": sodiumValue == null ? null : sodiumValue,
        "sugars": sugars == null ? null : sugars,
        "sugars_points": sugarsPoints == null ? null : sugarsPoints,
        "sugars_value": sugarsValue == null ? null : sugarsValue,
      };
}

class SelectedImages {
  SelectedImages({
    this.front,
  });

  final Front? front;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => SelectedImages(
        front: json["front"] == null ? null : Front().fromJson(json["front"]),
      );

  Map<String, dynamic> toJson() => {
        "front": front == null ? null : front?.toJson(),
      };
}

class Front {
  Front({
    this.display,
    this.small,
    this.thumb,
  });

  final Display? display;
  final Display? small;
  final Display? thumb;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => Front(
        display: json["display"] == null
            ? null
            : Display().fromJson(json["display"]),
        small: json["small"] == null ? null : Display().fromJson(json["small"]),
        thumb: json["thumb"] == null ? null : Display().fromJson(json["thumb"]),
      );

  Map<String, dynamic> toJson() => {
        "display": display == null ? null : display?.toJson(),
        "small": small == null ? null : small?.toJson(),
        "thumb": thumb == null ? null : thumb?.toJson(),
      };
}

class Display {
  Display({
    this.en,
  });

  final String? en;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => Display(
        en: json["en"] == null ? null : json["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en == null ? null : en,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

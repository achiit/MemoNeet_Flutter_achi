import 'package:memo_neet/MVVM/models/subjects/chapters/topics/topic_model.dart';
import 'package:memo_neet/MVVM/models/subjects/subject_model.dart';
import 'package:memo_neet/constants/images.dart';

import '../MVVM/models/subjects/chapters/chapter_model.dart';

class SubjectsData {
  List<SubjectModel> getSubjects() {
    return [
      SubjectModel(
          imageUrl: AppImages.bio,
          subjectName: "Biology",
          chapters: biologyChapters),
      SubjectModel(
          imageUrl: AppImages.chem,
          subjectName: "Chemistry",
          chapters: chemistryChapters),
      SubjectModel(
          imageUrl: AppImages.physics,
          subjectName: "Physics",
          chapters: physicsChapters)
    ];
  }

  //////////////////////////////
  // Biology Chapters
  //////////////////////////////
  List<ChapterModel> biologyChapters = [
    ChapterModel(
        chapterName: "Diversity In Living World",
        isFreeChapter: true,
        topics: [
          TopicModel(
            topicName: "The Living World",
            uidStart: "10101",
            uidEnd: "19999",
          ),
          TopicModel(
            topicName: "Biological Classification",
            uidStart: "20100",
            uidEnd: "29999",
          ),
          TopicModel(
            topicName: "Plant Kingdom",
            uidStart: "30100",
            uidEnd: "39999",
          ),
          TopicModel(
            topicName: "Animal Kingdom",
            uidStart: "40100",
            uidEnd: "49999",
          ),
          TopicModel(
              topicName: "Bookmarked Question",
              isBookmark: true,
              uidStart: "",
              uidEnd: "")
        ]),
    ChapterModel(
      chapterName: "Structural Organisation In Plants and Animals",
      isFreeChapter: true,
      topics: [
        TopicModel(
          topicName: "Morphology Of Flowering Plants",
          uidStart: "50100",
          uidEnd: "59999",
        ),
        TopicModel(
          topicName: "Plant Anatomy",
          uidStart: "60100",
          uidEnd: "69999",
        ),
        TopicModel(
          topicName: "Structural Organisation In Animals",
          uidStart: "70100",
          uidEnd: "79999",
        ),
      ],
    ),
    ChapterModel(
      chapterName: "Cell: Structure And Functions",
      topics: [
        TopicModel(
          topicName: "Cell : The Unit Of Life",
          uidStart: "80100",
          uidEnd: "89999",
        ),
        TopicModel(
          topicName: "Biomolecules",
          uidStart: "90100",
          uidEnd: "99999",
        ),
        TopicModel(
          topicName: "Cell Cycle and Division",
          uidStart: "100100",
          uidEnd: "109999",
        ),
      ],
    ),
    ChapterModel(chapterName: "Plant Physiology", topics: [
      TopicModel(
        topicName: "Transport In Plants",
        uidStart: "110100",
        uidEnd: "119999",
      ),
      TopicModel(
        topicName: "Mineral Nutrition",
        uidStart: "120100",
        uidEnd: "129999",
      ),
      TopicModel(
        topicName: "Photosynthesis In Higher Plants",
        uidStart: "130100",
        uidEnd: "139999",
      ),
      TopicModel(
        topicName: "Respiration In Plants",
        uidStart: "140100",
        uidEnd: "149999",
      ),
      TopicModel(
        topicName: "Plant Growth and Development",
        uidStart: "150100",
        uidEnd: "159999",
      ),
    ]),
    ChapterModel(chapterName: "Human Physiology", topics: [
      TopicModel(
        topicName: "Digestion & Absorption",
        uidStart: "160100",
        uidEnd: "169999",
      ),
      TopicModel(
        topicName: "Breathing & Exchange of Gases",
        uidStart: "170100",
        uidEnd: "179999",
      ),
      TopicModel(
        topicName: "Body Fluids & Circulation",
        uidStart: "180100",
        uidEnd: "189999",
      ),
      TopicModel(
        topicName: "Excretory Products & their Elimination",
        uidStart: "190100",
        uidEnd: "199999",
      ),
      TopicModel(
        topicName: "Locomotion & Movement",
        uidStart: "200100",
        uidEnd: "209999",
      ),
      TopicModel(
        topicName: "Neural Control & Coordination",
        uidStart: "210100",
        uidEnd: "219999",
      ),
      TopicModel(
        topicName: "Chemical Coordination & Integration",
        uidStart: "220100",
        uidEnd: "229999",
      ),
    ]),
    ChapterModel(chapterName: "Reproduction", topics: [
      TopicModel(
        topicName: "Reproduction in Organisms",
        uidStart: "230100",
        uidEnd: "239999",
      ),
      TopicModel(
        topicName: "Sexual Reproduction in Flowering Plants",
        uidStart: "240100",
        uidEnd: "249999",
      ),
      TopicModel(
        topicName: "Human Reproduction",
        uidStart: "250100",
        uidEnd: "259999",
      ),
      TopicModel(
        topicName: "Reproductive Health",
        uidStart: "260100",
        uidEnd: "269999",
      ),
    ]),
    ChapterModel(chapterName: "Genetics And Evolution", topics: [
      TopicModel(
        topicName: "Principles Of Inheritance And Variation",
        uidStart: "270100",
        uidEnd: "279999",
      ),
      TopicModel(
        topicName: "Molecular Basis of Inheritance",
        uidStart: "280100",
        uidEnd: "289999",
      ),
      TopicModel(
        topicName: "Evolution",
        uidStart: "290100",
        uidEnd: "299999",
      ),
    ]),
    ChapterModel(chapterName: "Biology And Human Welfare", topics: [
      TopicModel(
        topicName: "Human Health and Disease",
        uidStart: "300100",
        uidEnd: "309999",
      ),
      TopicModel(
        topicName: "Strategies for Enhancement in Food Production",
        uidStart: "310100",
        uidEnd: "319999",
      ),
      TopicModel(
        topicName: "Microbes in Human Welfare",
        uidStart: "320100",
        uidEnd: "329999",
      ),
    ]),
    ChapterModel(chapterName: "Biotechnology And Its Applications", topics: [
      TopicModel(
        topicName: "Biotechnology : Principles And Processes",
        uidStart: "330100",
        uidEnd: "339999",
      ),
      TopicModel(
        topicName: "Biotechnology And Its Applications",
        uidStart: "340100",
        uidEnd: "349999",
      ),
    ]),
    ChapterModel(chapterName: "Ecology", topics: [
      TopicModel(
        topicName: "Organisms And Populations",
        uidStart: "350100",
        uidEnd: "359999",
      ),
      TopicModel(
        topicName: "Ecosystem",
        uidStart: "360100",
        uidEnd: "369999",
      ),
      TopicModel(
        topicName: "Biodiversity and Conservation",
        uidStart: "370100",
        uidEnd: "379999",
      ),
      TopicModel(
        topicName: "Environmental Issues",
        uidStart: "380100",
        uidEnd: "389999",
      ),
    ]),
    ChapterModel(chapterName: "Assertion and Reasoning", topics: [
      TopicModel(
          topicName: "The Living World", uidStart: "10601", uidEnd: "10664"),
      TopicModel(
          topicName: "Biological Classification",
          uidStart: "21201",
          uidEnd: "21446"),
      TopicModel(
          topicName: "Plant Kingdom", uidStart: "31203", uidEnd: "31254"),
      TopicModel(
          topicName: "Animal Kingdom", uidStart: "41001", uidEnd: "41197"),
      TopicModel(
          topicName: "Morphology of Flowering Plants",
          uidStart: "51101",
          uidEnd: "51143"),
      TopicModel(
          topicName: "Anatomy of Flowering Plants",
          uidStart: "61001",
          uidEnd: "61061"),
      TopicModel(
          topicName: "Structural Organisation in Animals",
          uidStart: "70901",
          uidEnd: "70970"),
      TopicModel(
          topicName: "Cell The Unit Of Life",
          uidStart: "81101",
          uidEnd: "81182"),
      TopicModel(topicName: "Biomolecules", uidStart: "91501", uidEnd: "91667"),
      TopicModel(
          topicName: "Cell Cycle and Cell Division",
          uidStart: "101201",
          uidEnd: "101211"),
      TopicModel(
          topicName: "Transport in Plants",
          uidStart: "111501",
          uidEnd: "111583"),
      TopicModel(
          topicName: "Mineral Nutrition", uidStart: "121701", uidEnd: "121773"),
      TopicModel(
          topicName: "Photosynthesis", uidStart: "131501", uidEnd: "131626"),
      TopicModel(
          topicName: "Respiration in Plants",
          uidStart: "141401",
          uidEnd: "141448"),
      TopicModel(
          topicName: "Digestion and Absorption",
          uidStart: "161000",
          uidEnd: "161044"),
      TopicModel(
          topicName: "Plant Growth and Development",
          uidStart: "152101",
          uidEnd: "152142"),
      TopicModel(
          topicName: "Breathing and Exchange of Gases",
          uidStart: "171300",
          uidEnd: "171426"),
      TopicModel(
          topicName: "Body Fluids and circulation",
          uidStart: "181800",
          uidEnd: "181845"),
      TopicModel(
          topicName: "Excretory Products and their Elimination",
          uidStart: "191300",
          uidEnd: "191346"),
      TopicModel(
          topicName: "Locomotion and Movement",
          uidStart: "201500",
          uidEnd: "201545"),
      TopicModel(
          topicName: "Neural control and Coordination",
          uidStart: "211700",
          uidEnd: "211766"),
      TopicModel(
          topicName: "Chemical Coordination and Integration",
          uidStart: "221901",
          uidEnd: "221944"),
      TopicModel(
          topicName: "Reproduction in Organisms",
          uidStart: "231300",
          uidEnd: "231424"),
      TopicModel(
          topicName: "Sexual Reproduction in Flowering Plants",
          uidStart: "241801",
          uidEnd: "241938"),
      TopicModel(
          topicName: "Human Reproduction",
          uidStart: "251401",
          uidEnd: "251443"),
      TopicModel(
          topicName: "Reproductive Health",
          uidStart: "261201",
          uidEnd: "261247"),
      TopicModel(
          topicName: "Principles of Inheritance and Variation",
          uidStart: "271901",
          uidEnd: "272050"),
      TopicModel(
          topicName:
              "Molecular Basis of InheritanceMolecular Basis of Inheritance",
          uidStart: "282901",
          uidEnd: "283126"),
      TopicModel(topicName: "Evolution", uidStart: "291301", uidEnd: "291354"),
      TopicModel(
          topicName: "Human Health and Diseases",
          uidStart: "302201",
          uidEnd: "302285"),
      TopicModel(
          topicName: "Strategies for Enhancement of Food Production",
          uidStart: "311801",
          uidEnd: "311920"),
      TopicModel(
          topicName: "Microbes in Human Welfare",
          uidStart: "321201",
          uidEnd: "321258"),
      TopicModel(
          topicName: "Biotechnology- Principles and Processes",
          uidStart: "331501",
          uidEnd: "331562"),
      TopicModel(
          topicName: "Biotechnology- Applications",
          uidStart: "341101",
          uidEnd: "341141"),
      TopicModel(
          topicName: "Organisms and Populations",
          uidStart: "352301",
          uidEnd: "352458"),
      TopicModel(topicName: "Ecosystem", uidStart: "361001", uidEnd: "361114"),
      TopicModel(
          topicName: "Biodiversity", uidStart: "371101", uidEnd: "371245"),
      TopicModel(
          topicName: "Environmental Issues",
          uidStart: "381201",
          uidEnd: "381259"),
    ])
  ];

  //////////////////////////////
  // Chemistry Chapters
  //////////////////////////////
  List<ChapterModel> chemistryChapters = [
    ChapterModel(chapterName: "INORGANIC", isFreeChapter: true, topics: [
      TopicModel(
        topicName: "Classification of Elements and Periodicity in Properties",
        uidStart: "30101",
        uidEnd: "39999",
      ),
      TopicModel(
        topicName: "Chemical Bonding and Molecular Structure",
        uidStart: "40101",
        uidEnd: "49999",
      ),
      TopicModel(
          topicName: "Redox Reactions", uidStart: "220101", uidEnd: "229999"),
      TopicModel(topicName: "Hydrogen", uidStart: "90101", uidEnd: "99999"),
      TopicModel(
          topicName: "The s-Block Elements",
          uidStart: "100101",
          uidEnd: "109999"),
      TopicModel(
          topicName: "The p-Block Elements (Class 11)",
          uidStart: "110101",
          uidEnd: "119999"),
      TopicModel(
          topicName: "Environmental Chemistry",
          uidStart: "140101",
          uidEnd: "149999"),
      TopicModel(
          topicName:
              "General Principles and Processes of Isolation of Elements",
          uidStart: "200101",
          uidEnd: "209999"),
      TopicModel(
          topicName: "The p-Block Elements (Class 12)",
          uidStart: "210101",
          uidEnd: "219999"),
      TopicModel(
          topicName: "The d- and f-Block Elements",
          uidStart: "80101",
          uidEnd: "89999"),
      TopicModel(
          topicName: "Coordination Compounds",
          uidStart: "230101",
          uidEnd: "239999"),
    ]),
    ChapterModel(chapterName: "ORGANIC", isFreeChapter: true, topics: [
      TopicModel(
        topicName: "Organic Chemistry - Some Basic Principles and Techniques",
        uidStart: "120101",
        uidEnd: "129999",
      ),
      TopicModel(
        topicName: "Hydrocarbons",
        uidStart: "130101",
        uidEnd: "139999",
      ),
      TopicModel(
        topicName: "Haloalkanes and Haloarenes",
        uidStart: "240101",
        uidEnd: "249999",
      ),
      TopicModel(
        topicName: "Alcohols, Phenols and Ethers",
        uidStart: "250101",
        uidEnd: "259999",
      ),
      TopicModel(
        topicName: "Aldehydes, Ketones & Carboxylic Acids",
        uidStart: "260101",
        uidEnd: "269999",
      ),
      TopicModel(
        topicName: "Organic Compounds Containing Nitrogen",
        uidStart: "270101",
        uidEnd: "279999",
      ),
      TopicModel(
        topicName: "Biomolecules",
        uidStart: "280101",
        uidEnd: "289999",
      ),
      TopicModel(
        topicName: "Polymers",
        uidStart: "290101",
        uidEnd: "299999",
      ),
      TopicModel(
        topicName: "Chemistry in Everyday Life",
        uidStart: "300101",
        uidEnd: "309999",
      ),
    ]),
    ChapterModel(chapterName: "PHYSICAL", topics: [
      TopicModel(
        topicName: "Some Basic Concepts of Chemistry",
        uidStart: "10101",
        uidEnd: "19999",
      ),
      TopicModel(
        topicName: "Structure of Atom",
        uidStart: "20101",
        uidEnd: "29999",
      ),
      TopicModel(
        topicName: "States of Matter",
        uidStart: "50101",
        uidEnd: "59999",
      ),
      TopicModel(
        topicName: "Thermodynamics",
        uidStart: "60101",
        uidEnd: "69999",
      ),
      TopicModel(
        topicName: "Equilibrium",
        uidStart: "70101",
        uidEnd: "79999",
      ),
      TopicModel(
        topicName: "Solid state",
        uidStart: "150101",
        uidEnd: "159999",
      ),
      TopicModel(
        topicName: "Solutions",
        uidStart: "160101",
        uidEnd: "169999",
      ),
      TopicModel(
        topicName: "Electrochemistry",
        uidStart: "170101",
        uidEnd: "179999",
      ),
      TopicModel(
        topicName: "Chemical Kinetics",
        uidStart: "180101",
        uidEnd: "189999",
      ),
      TopicModel(
        topicName: "Surface Chemistry",
        uidStart: "190101",
        uidEnd: "199999",
      ),
    ]),
    ChapterModel(chapterName: "Physical Chemistry Formulae", topics: [
      TopicModel(
        topicName: "Some Basic Concepts of Chemistry",
        uidStart: "450101",
        uidEnd: "459999",
      ),
      TopicModel(
        topicName: "States of Matter",
        uidStart: "460101",
        uidEnd: "469999",
      ),
      TopicModel(
        topicName: "Thermodynamics",
        uidStart: "470101",
        uidEnd: "479999",
      ),
      TopicModel(
        topicName: "Chemical Equilibrium",
        uidStart: "480101",
        uidEnd: "489999",
      ),
      TopicModel(
        topicName: "Ionic Equilibrium",
        uidStart: "490101",
        uidEnd: "499999",
      ),
      TopicModel(
        topicName: "Redox Reaction",
        uidStart: "500101",
        uidEnd: "509999",
      ),
      TopicModel(
        topicName: "Solutions",
        uidStart: "510101",
        uidEnd: "519999",
      ),
      TopicModel(
        topicName: "Electrochemistry",
        uidStart: "520101",
        uidEnd: "529999",
      ),
      TopicModel(
        topicName: "Chemical Kinetics",
        uidStart: "530101",
        uidEnd: "539999",
      ),
      TopicModel(
        topicName: "Quantitative Estimation of Organic Compounds",
        uidStart: "540101",
        uidEnd: "549999",
      ),
      TopicModel(
        topicName: "Structure of Atom",
        uidStart: "550101",
        uidEnd: "559999",
      ),
    ]),
    ChapterModel(chapterName: "Organic Named Reactions", topics: [
      TopicModel(
        topicName: "Class 11",
        uidStart: "570101",
        uidEnd: "579999",
      ),
      TopicModel(
        topicName: "Class 12",
        uidStart: "560101",
        uidEnd: "569999",
      ),
    ]),
    ChapterModel(chapterName: "Advanced Questions", topics: [
      TopicModel(
        topicName: "Some Basic Concepts of Chemistry",
        uidStart: "11201",
        uidEnd: "11621",
      ),
      TopicModel(
        topicName: "Structure of Atom",
        uidStart: "22601",
        uidEnd: "22911",
      ),
      TopicModel(
        topicName: "Classification of Elements and Periodicity in Properties",
        uidStart: "31701",
        uidEnd: "32011",
      ),
      TopicModel(
        topicName: "Chemical Bonding and Molecular Structure",
        uidStart: "42001",
        uidEnd: "42125",
      ),
      TopicModel(
        topicName: "States of Matter: Gases and Liquids",
        uidStart: "51101",
        uidEnd: "51315",
      ),
      TopicModel(
        topicName: "Thermodynamics",
        uidStart: "61001",
        uidEnd: "61419",
      ),
      TopicModel(
        topicName: "Equilibrium",
        uidStart: "71301",
        uidEnd: "71774",
      ),
      TopicModel(
        topicName: "Redox Reactions",
        uidStart: "220901",
        uidEnd: "221323",
      ),
      TopicModel(
        topicName: "Hydrogen",
        uidStart: "92301",
        uidEnd: "92331",
      ),
      TopicModel(
        topicName: "Hydrocarbons",
        uidStart: "130901",
        uidEnd: "131305",
      ),
      TopicModel(
        topicName: "P-Block Elements - Class 11",
        uidStart: "114001",
        uidEnd: "114307",
      ),
      TopicModel(
        topicName: "Organic Chemistry- Some Basic Principles and Techniques",
        uidStart: "121401",
        uidEnd: "121529",
      ),
      TopicModel(
        topicName: "s-Block Element (Alkali and Alkaline earth metals)",
        uidStart: "101601",
        uidEnd: "101910",
      ),
      TopicModel(
        topicName: "Environmental Chemistry",
        uidStart: "141801",
        uidEnd: "142011",
      ),
      TopicModel(
        topicName: "Solid State",
        uidStart: "151301",
        uidEnd: "151615",
      ),
      TopicModel(
        topicName: "Solution",
        uidStart: "161001",
        uidEnd: "161336",
      ),
      TopicModel(
        topicName: "Electrochemistry",
        uidStart: "171201",
        uidEnd: "171526",
      ),
      TopicModel(
        topicName: "Surface chemistry",
        uidStart: "190701",
        uidEnd: "190937",
      ),
      TopicModel(
        topicName: "General Principles and Processes of Isolation of Elements",
        uidStart: "201101",
        uidEnd: "201307",
      ),
      TopicModel(
        topicName: "p-Block Elements - CLass 12",
        uidStart: "231401",
        uidEnd: "231633",
      ),
      TopicModel(
        topicName: "Coordination Compounds",
        uidStart: "214301",
        uidEnd: "214527",
      ),
      TopicModel(
        topicName: "Alcohols, Phenols and Ethers",
        uidStart: "251001",
        uidEnd: "251418",
      ),
      TopicModel(
        topicName: "Aldehydes, Ketones and Carboxylic Acids",
        uidStart: "261401",
        uidEnd: "261808",
      ),
      TopicModel(
        topicName: "Organic Compounds Containing Nitrogen",
        uidStart: "270901",
        uidEnd: "271514",
      ),
      TopicModel(
        topicName: "Haloalkanes and Haloarenes",
        uidStart: "241201",
        uidEnd: "241717",
      ),
      TopicModel(
        topicName: "Biomolecules",
        uidStart: "281401",
        uidEnd: "281520",
      ),
      TopicModel(
        topicName: "Polymers",
        uidStart: "290901",
        uidEnd: "291010",
      ),
      TopicModel(
        topicName: "Chemistry in Everyday Life",
        uidStart: "300801",
        uidEnd: "301004",
      ),
    ]),
    ChapterModel(chapterName: "Assertion and Reasoning", topics: [
      TopicModel(
        topicName: "Some Basic Concepts of Chemistry",
        uidStart: "11701",
        uidEnd: "11706",
      ),
      TopicModel(
        topicName: "Structure of Atom",
        uidStart: "23001",
        uidEnd: "23015",
      ),
      TopicModel(
        topicName: "Classification of Elements and Periodicity in Properties",
        uidStart: "32101",
        uidEnd: "32122",
      ),
      TopicModel(
        topicName: "Chemical Bonding and Molecular Structure",
        uidStart: "42201",
        uidEnd: "42277",
      ),
      TopicModel(
        topicName: "Thermodynamics",
        uidStart: "61501",
        uidEnd: "61515",
      ),
      TopicModel(
        topicName: "Equilibrium",
        uidStart: "71801",
        uidEnd: "71820",
      ),
      TopicModel(
        topicName: "Redox Reactions",
        uidStart: "221401",
        uidEnd: "221434",
      ),
      TopicModel(
        topicName: "s-Block Element (Alkali and Alkaline earth metals)",
        uidStart: "102001",
        uidEnd: "102038",
      ),
      TopicModel(
        topicName: "Some p-Block Elements(Class 11)",
        uidStart: "114401",
        uidEnd: "114438",
      ),
      TopicModel(
        topicName: "Organic Chemistry- Some Basic Principles and Techniques",
        uidStart: "121601",
        uidEnd: "121612",
      ),
      TopicModel(
        topicName: "Hydrocarbons",
        uidStart: "131401",
        uidEnd: "131425",
      ),
      TopicModel(
        topicName: "Environmental Chemistry",
        uidStart: "142001",
        uidEnd: "142011",
      ),
      TopicModel(
        topicName: "Solid State",
        uidStart: "151401",
        uidEnd: "151420",
      ),
      TopicModel(
        topicName: "Solutions",
        uidStart: "161401",
        uidEnd: "161418",
      ),
      TopicModel(
        topicName: "Surface Chemistry",
        uidStart: "191001",
        uidEnd: "191010",
      ),
      TopicModel(
        topicName: "General Principles and Processes of Isolation of Elements",
        uidStart: "201401",
        uidEnd: "201424",
      ),
      TopicModel(
        topicName: "p-Block Elements(Class 12)",
        uidStart: "214601",
        uidEnd: "214639",
      ),
      TopicModel(
        topicName: "Coordination Compounds",
        uidStart: "231701",
        uidEnd: "231720",
      ),
      TopicModel(
        topicName: "Alcohols, Phenols and Ethers",
        uidStart: "251501",
        uidEnd: "251518",
      ),
      TopicModel(
        topicName: "Aldehydes, Ketones and Carboxylic Acids",
        uidStart: "261901",
        uidEnd: "261916",
      ),
      TopicModel(
        topicName: "Organic Compounds Containing Nitrogen",
        uidStart: "271601",
        uidEnd: "271613",
      ),
      TopicModel(
        topicName: "Polymers",
        uidStart: "291101",
        uidEnd: "291116",
      ),
    ]),
  ];

  //////////////////////////////
  // Physics Chapters
  //////////////////////////////
  List<ChapterModel> physicsChapters = [
    ChapterModel(
        chapterName: "Class 11 - Lecture Videos",
        isFreeChapter: true,
        topics: [
          TopicModel(
            topicName: "Units and Measurements",
            uidStart: "20100",
            uidEnd: "20200",
          ),
          TopicModel(
            topicName: "Kinematics",
            uidStart: "30100",
            uidEnd: "30700",
          ),
          TopicModel(
            topicName: "Laws of Motion",
            uidStart: "50100",
            uidEnd: "50400",
          ),
          TopicModel(
            topicName: "Work, Energy and Power",
            uidStart: "60100",
            uidEnd: "60400",
          ),
          TopicModel(
            topicName: "Systems of Particles and Rotational Motion",
            uidStart: "70100",
            uidEnd: "70500",
          ),
          TopicModel(
            topicName: "Gravitation",
            uidStart: "80100",
            uidEnd: "80500",
          ),
          TopicModel(
            topicName: "Mechanical Properties of Solids",
            uidStart: "90100",
            uidEnd: "90200",
          ),
          TopicModel(
            topicName: "Mechanical Properties of Fluids",
            uidStart: "100100",
            uidEnd: "100600",
          ),
          TopicModel(
            topicName: "Thermal Properties of Matters",
            uidStart: "110100",
            uidEnd: "110200",
          ),
          TopicModel(
            topicName: "Thermodynamics",
            uidStart: "120100",
            uidEnd: "120400",
          ),
          TopicModel(
            topicName: "Kinetic Theory",
            uidStart: "130100",
            uidEnd: "130101",
          ),
          TopicModel(
            topicName: "Oscillations - SHM",
            uidStart: "140100",
            uidEnd: "140700",
          ),
          TopicModel(
            topicName: "Waves",
            uidStart: "150100",
            uidEnd: "150700",
          ),
        ]),
    ChapterModel(
        chapterName: "Class 12 - Lecture Videos",
        isFreeChapter: true,
        topics: [
          TopicModel(
            topicName: "Electrostatics",
            uidStart: "160100",
            uidEnd: "160700",
          ),
          TopicModel(
            topicName: "Current Electricity",
            uidStart: "170100",
            uidEnd: "170500",
          ),
          TopicModel(
            topicName: "Magnetic effects of Electric Current",
            uidStart: "180100",
            uidEnd: "180500",
          ),
          TopicModel(
            topicName: "Magnetism",
            uidStart: "190100",
            uidEnd: "190400",
          ),
          TopicModel(
            topicName: "EMI & AC",
            uidStart: "200100",
            uidEnd: "200700",
          ),
          TopicModel(
            topicName: "EM Waves",
            uidStart: "210100",
            uidEnd: "210101",
          ),
          TopicModel(
            topicName: "Ray Optics",
            uidStart: "220100",
            uidEnd: "220800",
          ),
          TopicModel(
            topicName: "Wave Optics",
            uidStart: "230100",
            uidEnd: "230500",
          ),
          TopicModel(
            topicName: "Dual Nature of Matter and Radiation",
            uidStart: "240100",
            uidEnd: "240300",
          ),
          TopicModel(
            topicName: "Atoms",
            uidStart: "250100",
            uidEnd: "250300",
          ),
          TopicModel(
            topicName: "Nuclei",
            uidStart: "260100",
            uidEnd: "260200",
          ),
          TopicModel(
            topicName: "Semiconductor",
            uidStart: "270100",
            uidEnd: "270500",
          ),
        ]),
    ChapterModel(chapterName: "Class 11 - NCERT Book Back", topics: [
      TopicModel(
        topicName: "Physical World",
        uidStart: "910101",
        uidEnd: "919999",
      ),
      TopicModel(
        topicName: "Units and dimensions",
        uidStart: "920101",
        uidEnd: "929999",
      ),
      TopicModel(
        topicName: "Motion in straight line",
        uidStart: "930101",
        uidEnd: "939999",
      ),
      TopicModel(
        topicName: "Motion in a Plane",
        uidStart: "940101",
        uidEnd: "949999",
      ),
      TopicModel(
        topicName: "Laws of motion",
        uidStart: "950101",
        uidEnd: "959999",
      ),
      TopicModel(
        topicName: "Work, Energy, and Power",
        uidStart: "960101",
        uidEnd: "969999",
      ),
      TopicModel(
        topicName: "System of particles and rotational motion",
        uidStart: "970101",
        uidEnd: "979999",
      ),
      TopicModel(
        topicName: "Gravitation",
        uidStart: "980101",
        uidEnd: "989999",
      ),
      TopicModel(
        topicName: "Mechanical properties of solids",
        uidStart: "990101",
        uidEnd: "999999",
      ),
      TopicModel(
        topicName: "Thermal properties of matters",
        uidStart: "1010101",
        uidEnd: "1019999",
      ),
      TopicModel(
        topicName: "Thermodynamics",
        uidStart: "1020101",
        uidEnd: "1029999",
      ),
      TopicModel(
        topicName: "Kinetic Theory",
        uidStart: "1030101",
        uidEnd: "1039999",
      ),
      TopicModel(
        topicName: "Oscillations",
        uidStart: "1040101",
        uidEnd: "1049999",
      ),
      TopicModel(
        topicName: "Waves",
        uidStart: "1050101",
        uidEnd: "1059999",
      ),
    ]),
    ChapterModel(chapterName: "Class 12 - NCERT Book Back", topics: [
      TopicModel(
        topicName: "Electric Charges and Fields",
        uidStart: "1060101",
        uidEnd: "1069999",
      ),
      TopicModel(
        topicName: "Electrostatic Potential and Capacitance",
        uidStart: "1070101",
        uidEnd: "1079999",
      ),
      TopicModel(
        topicName: "Current Electricity",
        uidStart: "1080101",
        uidEnd: "1089999",
      ),
      TopicModel(
        topicName: "Moving Charges and Magnetism",
        uidStart: "1090101",
        uidEnd: "1099999",
      ),
      TopicModel(
        topicName: "Magnetism and Matter",
        uidStart: "1100101",
        uidEnd: "1109999",
      ),
      TopicModel(
        topicName: "Electromagnetic Induction",
        uidStart: "1110101",
        uidEnd: "1119999",
      ),
      TopicModel(
        topicName: "Alternating current",
        uidStart: "1120101",
        uidEnd: "1129999",
      ),
      TopicModel(
        topicName: "Electromagnetic waves",
        uidStart: "1130101",
        uidEnd: "1139999",
      ),
      TopicModel(
        topicName: "Atoms",
        uidStart: "1170101",
        uidEnd: "1179999",
      ),
      TopicModel(
        topicName: "Nuclei",
        uidStart: "1180101",
        uidEnd: "1189999",
      ),
      TopicModel(
        topicName:
            "Semiconductor Electronics: Materials, Devices and Simple Circuits",
        uidStart: "1190101",
        uidEnd: "1199999",
      ),
      TopicModel(
        topicName: "Communication Systems",
        uidStart: "1200101",
        uidEnd: "1209999",
      ),
    ]),
    ChapterModel(chapterName: "Class 11 - Concept Building Questions", topics: [
      TopicModel(
        topicName: "Units and Measurements",
        uidStart: "20301",
        uidEnd: "29999",
      ),
      TopicModel(
        topicName: "Kinematics",
        uidStart: "30801",
        uidEnd: "39999",
      ),
      TopicModel(
        topicName: "Laws of Motion",
        uidStart: "50501",
        uidEnd: "59999",
      ),
      TopicModel(
        topicName: "Work, Energy and Power",
        uidStart: "60501",
        uidEnd: "69999",
      ),
      TopicModel(
        topicName: "Systems of Particles and Rotational Motion",
        uidStart: "70601",
        uidEnd: "79999",
      ),
      TopicModel(
        topicName: "Gravitation",
        uidStart: "80601",
        uidEnd: "89999",
      ),
      TopicModel(
        topicName: "Mechanical Properties of Solids",
        uidStart: "90301",
        uidEnd: "99999",
      ),
      TopicModel(
        topicName: "Mechanical Properties of Fluids",
        uidStart: "100701",
        uidEnd: "109999",
      ),
      TopicModel(
        topicName: "Thermodynamics",
        uidStart: "120501",
        uidEnd: "129999",
      ),
      TopicModel(
        topicName: "Kinetic Theory",
        uidStart: "130201",
        uidEnd: "139999",
      ),
      TopicModel(
        topicName: "Oscillations - SHM",
        uidStart: "140801",
        uidEnd: "149999",
      ),
      TopicModel(
        topicName: "Waves",
        uidStart: "150801",
        uidEnd: "159999",
      ),
    ]),
    ChapterModel(chapterName: "Class 12 - Concept Building Questions", topics: [
      TopicModel(
        topicName: "Electrostatics",
        uidStart: "160801",
        uidEnd: "169999",
      ),
      TopicModel(
        topicName: "Current Electricity",
        uidStart: "170601",
        uidEnd: "179999",
      ),
      TopicModel(
        topicName: "Magnetic effects of Electric Current",
        uidStart: "180601",
        uidEnd: "189999",
      ),
      TopicModel(
        topicName: "Magnetism",
        uidStart: "190501",
        uidEnd: "199999",
      ),
      TopicModel(
        topicName: "EMI & AC",
        uidStart: "200801",
        uidEnd: "209999",
      ),
      TopicModel(
        topicName: "EM Waves",
        uidStart: "210201",
        uidEnd: "219999",
      ),
      TopicModel(
        topicName: "Ray Optics",
        uidStart: "220901",
        uidEnd: "229999",
      ),
      TopicModel(
        topicName: "Wave Optics",
        uidStart: "230601",
        uidEnd: "239999",
      ),
      TopicModel(
        topicName: "Dual Nature of Matter and Radiation",
        uidStart: "240401",
        uidEnd: "249999",
      ),
      TopicModel(
        topicName: "Atoms",
        uidStart: "250401",
        uidEnd: "259999",
      ),
      TopicModel(
        topicName: "Nuclei",
        uidStart: "260301",
        uidEnd: "269999",
      ),
      TopicModel(
        topicName: "Semiconductor",
        uidStart: "270601",
        uidEnd: "279999",
      ),
    ]),
    ChapterModel(
      chapterName: "Revise Physics Formulae",
      topics: [
        TopicModel(
          topicName: "Units and Measurements",
          uidStart: "610101",
          uidEnd: "619999",
        ),
        TopicModel(
          topicName: "Kinematics",
          uidStart: "620101",
          uidEnd: "629999",
        ),
        TopicModel(
          topicName: "Laws of Motion",
          uidStart: "630101",
          uidEnd: "639999",
        ),
        TopicModel(
          topicName: "Work, Energy and Power",
          uidStart: "640101",
          uidEnd: "649999",
        ),
        TopicModel(
          topicName: "Systems of Particles and Rotational Motion",
          uidStart: "650101",
          uidEnd: "659999",
        ),
        TopicModel(
          topicName: "Gravitation",
          uidStart: "660101",
          uidEnd: "669999",
        ),
        TopicModel(
          topicName: "Mechanical Properties of Solids",
          uidStart: "670101",
          uidEnd: "679999",
        ),
        TopicModel(
          topicName: "Mechanical Properties of Fluids",
          uidStart: "700101",
          uidEnd: "709999",
        ),
        TopicModel(
          topicName: "Thermal Properties of Matter",
          uidStart: "710101",
          uidEnd: "719999",
        ),
        TopicModel(
          topicName: "Thermodynamics",
          uidStart: "720101",
          uidEnd: "729999",
        ),
        TopicModel(
          topicName: "Kinetic theory",
          uidStart: "730101",
          uidEnd: "739999",
        ),
        TopicModel(
          topicName: "Waves",
          uidStart: "750101",
          uidEnd: "759999",
        ),
        TopicModel(
          topicName: "Oscillation",
          uidStart: "760101",
          uidEnd: "769999",
        ),
        TopicModel(
          topicName: "Electrostatics",
          uidStart: "770101",
          uidEnd: "779999",
        ),
        TopicModel(
          topicName: "Current Electricity",
          uidStart: "780101",
          uidEnd: "789999",
        ),
        TopicModel(
          topicName: "Magnetic Effects of Current",
          uidStart: "790101",
          uidEnd: "799999",
        ),
        TopicModel(
          topicName: "Magnetism",
          uidStart: "800101",
          uidEnd: "809999",
        ),
        TopicModel(
          topicName: "Electromagnetic Induction",
          uidStart: "810101",
          uidEnd: "819999",
        ),
        TopicModel(
          topicName: "Alternating Currents",
          uidStart: "820101",
          uidEnd: "829999",
        ),
        TopicModel(
          topicName: "Electromagnetic waves",
          uidStart: "830101",
          uidEnd: "839999",
        ),
        TopicModel(
          topicName: "Ray optics",
          uidStart: "840101",
          uidEnd: "849999",
        ),
        TopicModel(
          topicName: "Wave optics",
          uidStart: "850101",
          uidEnd: "859999",
        ),
        TopicModel(
          topicName: "Dual Nature of Matter and Radiation",
          uidStart: "860101",
          uidEnd: "869999",
        ),
        TopicModel(
          topicName: "Atoms",
          uidStart: "870101",
          uidEnd: "879999",
        ),
        TopicModel(
          topicName: "Nuclei",
          uidStart: "880101",
          uidEnd: "889999",
        ),
        TopicModel(
          topicName: "Semiconductors",
          uidStart: "890101",
          uidEnd: "899999",
        ),
      ],
    ),
    ChapterModel(
      chapterName: "Class 11 - PYQ's with Videos & PYQ based Similar Questions",
      topics: [
        TopicModel(
          topicName: "Units and Measurements",
          uidStart: "320101",
          uidEnd: "329999",
        ),
        TopicModel(
          topicName: "Motion in a Straight Line",
          uidStart: "340101",
          uidEnd: "349999",
        ),
        TopicModel(
          topicName: "Motion in a Plane",
          uidStart: "330101",
          uidEnd: "339999",
        ),
        TopicModel(
          topicName: "Laws of Motion newton",
          uidStart: "350101",
          uidEnd: "359999",
        ),
        TopicModel(
          topicName: "Work, Energy and Power",
          uidStart: "360101",
          uidEnd: "369999",
        ),
        TopicModel(
          topicName: "Systems of Particles and Rotational Motion",
          uidStart: "370101",
          uidEnd: "379999",
        ),
        TopicModel(
          topicName: "Gravitation",
          uidStart: "380101",
          uidEnd: "389999",
        ),
        TopicModel(
          topicName: "Mechanical Properties of Solids",
          uidStart: "390101",
          uidEnd: "399999",
        ),
        TopicModel(
          topicName: "Mechanical Properties of Fluids",
          uidStart: "400101",
          uidEnd: "409999",
        ),
        TopicModel(
          topicName: "Thermal properties of matter",
          uidStart: "410101",
          uidEnd: "419999",
        ),
        TopicModel(
          topicName: "Thermodynamics",
          uidStart: "420101",
          uidEnd: "429999",
        ),
        TopicModel(
          topicName: "Kinetic Theory",
          uidStart: "430101",
          uidEnd: "439999",
        ),
        TopicModel(
          topicName: "Oscillations - SHM",
          uidStart: "440101",
          uidEnd: "449999",
        ),
        TopicModel(
          topicName: "Waves",
          uidStart: "450101",
          uidEnd: "459999",
        ),
      ],
    ),
    ChapterModel(
      chapterName: "Class 12 - PYQ's with Videos & PYQ based Similar Questions",
      topics: [
        TopicModel(
          topicName: "Electrostatics",
          uidStart: "460101",
          uidEnd: "469999",
        ),
        TopicModel(
          topicName: "Electrostatic Potential and Capacitance",
          uidStart: "470101",
          uidEnd: "479999",
        ),
        TopicModel(
          topicName: "Current Electricity",
          uidStart: "480101",
          uidEnd: "489999",
        ),
        TopicModel(
          topicName: "Moving Charges and Magnetism",
          uidStart: "490101",
          uidEnd: "499999",
        ),
        TopicModel(
          topicName: "Magnetism and Matter",
          uidStart: "500101",
          uidEnd: "509999",
        ),
        TopicModel(
          topicName: "Electromagnetic Induction",
          uidStart: "510101",
          uidEnd: "519999",
        ),
        TopicModel(
          topicName: "Alternating current",
          uidStart: "520101",
          uidEnd: "529999",
        ),
        TopicModel(
          topicName: "Electromagnetic Waves",
          uidStart: "530101",
          uidEnd: "539999",
        ),
        TopicModel(
          topicName: "Ray optics and Optical instrument",
          uidStart: "540101",
          uidEnd: "549999",
        ),
        TopicModel(
          topicName: "Wave optics",
          uidStart: "550101",
          uidEnd: "559999",
        ),
        TopicModel(
          topicName: "Dual Nature of Radiation and Matter",
          uidStart: "570101",
          uidEnd: "579999",
        ),
        TopicModel(
          topicName: "Atoms",
          uidStart: "580101",
          uidEnd: "589999",
        ),
        TopicModel(
          topicName: "Nuclei",
          uidStart: "590101",
          uidEnd: "599999",
        ),
        TopicModel(
          topicName: "Semiconductor",
          uidStart: "600101",
          uidEnd: "609999",
        ),
      ],
    ),
  ];
}

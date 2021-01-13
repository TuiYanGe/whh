import 'dart:convert';

// ignore: public_member_api_docs
const List<Map<String, dynamic>> HELLO_WORLD = [
  {
    "label": "H",
    "children": [
      {'label': "E", "key": "E1"},
      {"label": "E", "key": "E2"},
      {"label": "L", "key": "L"},
      {"label": "O", "key": "O"},

    ]
  },
    {
    "label": "W",
    "children": [
      {"label": "O", 
      "children": [
        {"label": "W",
          "children": [
            {"label": "R",
             "children": [
              {"label": "L",
                "children": [
                  {"label": "D","key":"D",}
                ]
              }
            ]
          }
        ]
        }
      ]}
    ]
  },

];

String HELLO_WORLD_JSON = jsonEncode(HELLO_WORLD);
import 'package:flutter/material.dart';

///Quiz Collection
const FIREBASE_MAIN_QUIZ_COLLECTION = "question_main_collection";
const FIREBASE_MAIN_QUIZ_DOCUMENT = 'new_york';
const FIREBASE_QUIZ_MAIN_TOPIC_ARRAY = 'main_topic';
const FIREBASE_QUIZ_SUB_TOPICS_DOCUMENT = 'sub-topics';

//const FIREBASE_PATH_TO_TOPICS = '$FIREBASE_MAIN_QUIZ_COLLECTION/ny/topics';


//Documents Keys
const FIREBASE_FIELD_QUESTION = 'Question';
const FIREBASE_FIELD_OPTION1 = 'Option_1';
const FIREBASE_FIELD_OPTION2 = 'Option_2';
const FIREBASE_FIELD_OPTION3 = 'Option_3';
const FIREBASE_FIELD_OPTION4 = 'Option_4';
const FIREBASE_FIELD_ANSWER = 'Answers';


///User Collection
const FIREBASE_MAIN_USER_COLLECTION = "user_main_collection";
const FIREBASE_MAIN_USER_DOCUMENT = 'new_york';
const FIREBASE_USER_DETAIL_DOCUMENT = 'user_detail';
const FIREBASE_USER_SCORE_DETAIL_DOCUMENT = 'score_detail';

const FIREBASE_USER_DETAIL_FIELD_FULL_NAME = 'full_name';
const FIREBASE_USER_DETAIL_FIELD_USER_PIC = 'user_picture';

const FIREBASE_USER_SCORE_DETAIL_FIELD_CURRENT_SCORE = 'current_score';
const FIREBASE_USER_SCORE_DETAIL_FIELD_TOTAL_PLAYED_QUESTIONS = 'total_played_questions';
const FIREBASE_USER_SCORE_DETAIL_FIELD_RECENT_PLAYED = 'recent_played';
const FIREBASE_USER_SCORE_DETAIL_FIELD_POINT_RECEIVED = 'points_received';
const FIREBASE_USER_SCORE_DETAIL_FIELD_TOPIC_NAME = 'topic_name';
const FIREBASE_USER_SCORE_DETAIL_FIELD_TIMESTAMP = 'timestamp';
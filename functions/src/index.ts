import * as functions from 'firebase-functions'
import { kakaoAuth, naverAuth, createUser, createDefaultMuscles } from './auth'
import { initializeApp } from 'firebase-admin/app'
import { firestore } from 'firebase-admin'

const firebaseConfig = {
  apiKey: "AIzaSyBtlomOQ-gz7R_KMpKlCRkyhsP_Tf4fuvs",
  authDomain: "gymcalendar-20206.firebaseapp.com",
  projectId: "gymcalendar-20206",
  storageBucket: "gymcalendar-20206.appspot.com",
  messagingSenderId: "475767358760",
  appId: "1:475767358760:web:c93fecf56bd87028a03c1d",
  measurementId: "G-DGSJ17YDV0",
  serviceAccountId: 'firebase-adminsdk-khwcu@gymcalendar-20206.iam.gserviceaccount.com',
};

initializeApp(firebaseConfig);
firestore().settings({ignoreUndefinedProperties:true});

exports.kakaoAuth = functions
  .runWith({ secrets: ['service_account_key'] })
  .https.onRequest(kakaoAuth)
exports.naverAuth = functions
  .runWith({ secrets: ['service_account_key'] })
  .https.onRequest(naverAuth)

exports.createUser = createUser
exports.createDefaultMuscles = createDefaultMuscles
import * as functions from "firebase-functions";
import { kakaoAuth, naverAuth } from './auth'
import { initializeApp } from "firebase-admin/app";

initializeApp();
exports.kakaoAuth = functions.runWith({ secrets: ["service_account_key"] }).https.onRequest(kakaoAuth);
exports.naverAuth = functions.runWith({ secrets: ["service_account_key"] }).https.onRequest(naverAuth);
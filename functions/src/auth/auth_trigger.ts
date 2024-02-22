
import * as functions from "firebase-functions";
import { firestore, auth } from 'firebase-admin'
import { Timestamp } from "firebase-admin/firestore";

interface UserModel {
    email?: String,
    emailVerified: boolean,
    displayName?: String,
    photoURL?: String,
    phoneNumber?: String,
    uid: String,
    disabled: boolean,
    creationTime: String,
    lastSignInTime: String,
    lastRefreshTime?: String | null
    fcmToken?: String
}

interface MuscleModel {
    createdAt:Timestamp,
    name: String,
    uid: String,
}

export const createUser = functions.auth.user().onCreate(async (user) => {
    try {
        const uid = user.uid;
        const userData: UserModel = {
            email: user.email,
            emailVerified: user.emailVerified,
            displayName: user.displayName || 'Anonymous',
            photoURL: user.photoURL,
            phoneNumber: user.phoneNumber,
            disabled: user.disabled,
            uid: uid,
            creationTime: user?.metadata?.creationTime,
            lastSignInTime: user?.metadata?.lastSignInTime,
            fcmToken:''
        }
        const res = await firestore().collection('users').doc().set(userData, { merge: true })
        const jsonSuccess = await JSON.stringify(res);
        console.log(`success Login ${jsonSuccess}`)
    } catch (error) {
        await auth().deleteUser(user.uid);
        console.log(`error Login ${error}`)
    }
});


export const createDefaultMuscles = functions.auth.user().onCreate(async (user) => {
    try {
        const defaultMuscles = [
            '어깨',
            '승모',
            '가슴',
            '이두',
            '삼두',
            '전완',
            '복부',
            '등',
            '허리',
            '둔부',
            '대퇴',
            '슬굴곡근(햄스트링)',
            '종아리',]

        for (const [, element] of defaultMuscles.entries()) {
            const muscleData: MuscleModel = {
                uid: user.uid,
                name: element,
                createdAt:Timestamp.now()
            };
            try {
                const res = await firestore().collection('user_muscles').doc().set(muscleData, { merge: false });
                const jsonSuccess = JSON.stringify(res);
                console.log(`success Login ${jsonSuccess}`);
            } catch (error) {
                await auth().deleteUser(user.uid);
                console.log(`error Login ${error}`);
            }
        }

    } catch (error) {
        await auth().deleteUser(user.uid);
        console.log(`error Login ${error}`)
    }
});
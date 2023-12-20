
import * as functions from "firebase-functions";
import { firestore, auth} from 'firebase-admin'

interface UserModel {
    email?:String,
    emailVerified:boolean,
    displayName?:String,
    photoURL?:String,
    phoneNumber?:String,
    uid:String,
    disabled:boolean,
    creationTime:String,
    lastSignInTime:String,
    lastRefreshTime?:String|null
    fcmToken?:String
}

export const createUser = functions.auth.user().onCreate(async(user) => {
    try{
        const uid = user.uid;
        const userData:UserModel = {
            email:user.email,
            emailVerified:user.emailVerified,
            displayName:user.displayName || 'Anonymous',
            photoURL:user.photoURL,
            phoneNumber:user.phoneNumber,
            disabled:user.disabled,
            uid:uid,
            creationTime:user?.metadata?.creationTime,
            lastSignInTime:user?.metadata?.lastSignInTime,
        }
        const res = await firestore().collection('users').doc().set(userData,{merge:true})
        const jsonSuccess = await JSON.stringify(res);
        console.log(`success Login ${jsonSuccess}`)
    }catch(error){
        await auth().deleteUser(user.uid);
        console.log(`error Login ${error}`)
    }
  });

import * as functions from "firebase-functions";
import { firestore, auth} from 'firebase-admin'

interface UserModel {
    email?:string,
    emailVerified:boolean,
    displayName?:string,
    photoURL?:string,
    phoneNumber?:string,
    uid:string,
    disabled:boolean,
    creationTime:string,
    lastSignInTime:string,
    lastRefreshTime?:string|null
}

export const createUser = functions.auth.user().onCreate(async(user) => {
    try{
        const uid = user.uid;
        const userData:UserModel = {
            email:user.email,
            emailVerified:user.emailVerified,
            displayName:user.displayName,
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
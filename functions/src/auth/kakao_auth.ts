import axios from "axios";
import { config } from "dotenv";
import * as express from "express"
import * as cors from "cors"
import { UserRecord } from "firebase-admin/auth";
const admin = require('firebase-admin')

config({path:'../../.env'});

const kakaoAuth = express();
kakaoAuth.use(cors({ origin: true }));

const getKakaoUser = async (token: string): Promise<KakaoUser|null> => {
  try{
  const res = await axios.get(
    "https://kapi.kakao.com/v2/user/me",
    { headers: { Authorization: `Bearer ${token}` },
  });
  return res.data;
  }catch(error){
    console.log('getKakaoUser Error',error)
    return null
  }
};

const getAdminApp = () => {
  try{
    const app = !admin.apps.length
      ? admin.initializeApp({
        credential: admin.credential.applicationDefault(),
        })
      : admin.app();
  
    return app;
  }catch(error){
    console.log('getAdminApp error',error)
  }
};


const updateOrCreateUser = async (user: KakaoUser): Promise<UserRecord|null> => {
  const app = getAdminApp();
  const auth = admin.auth(app);
  const kakaoAccount = user.kakao_account;
  const properties = {
    uid: `kakao:${user.id}`,
    provider: "KAKAO",
    displayName: kakaoAccount?.profile?.nickname,
    email: kakaoAccount?.email,
  };

  try{
    return await auth.updateUser(properties.uid, properties);
  }catch(error:any){
    if (error.code === "auth/user-not-found") {
      return await auth.createUser(properties);
    }
    return null;
  }

};

kakaoAuth.post("/kakaoLogin", async (req, res) => {
  const { code } = req.body;

  if (!code) {
    return res.status(400).json({
      code: 400,
      message: "code is a required parameter.",
    });
  }

  const kakaoUser = await getKakaoUser(code);

  if(!kakaoUser){
    return res.status(400).json({
      code: 400,
      message: "no KakaoUser.",
    });
  }
  
  const authUser = await updateOrCreateUser(kakaoUser);

  if(!authUser ){
    return res.status(400).json({
      code: 400,
      message: "no User.",
    });
  }
  
  const firebaseToken = await admin
      .auth()
      .createCustomToken(authUser.uid, { provider: "KAKAO" });
  return res.status(200).json({ firebaseToken });
});

export default kakaoAuth
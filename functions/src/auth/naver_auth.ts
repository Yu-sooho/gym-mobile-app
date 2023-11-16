import axios from "axios";
import { config } from "dotenv";
import * as express from "express"
import * as cors from "cors"
import { UserRecord } from "firebase-admin/auth";
const admin = require('firebase-admin')

config({path:'../../.env'});

const naverAuth = express();
naverAuth.use(cors({ origin: true }));

const getNaverUser = async (token: string): Promise<NaverUser|null> => {
  try{
  const res = await axios.get(
    "https://openapi.naver.com/v1/nid/me",
    { headers: { Authorization: `Bearer ${token}` },
  });
  return res.data.response;
  }catch(error){
    console.log('getNaverUser Error',error)
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
    return null
  }
};

const updateOrCreateUser = async (user: NaverUser): Promise<UserRecord|null> => {
  const app = getAdminApp();
  const auth = admin.auth(app);
  const properties = {
    uid: `naver:${user.id}`,
    provider: "Naver",
    displayName: user?.nickname,
    email: user?.email,
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

naverAuth.post("/naverLogin", async (req, res) => {
  try{
    const { code } = req.body;
  
    if (!code) {
       return res.status(400).json({
        code: 400,
        message: "code is a required parameter.",
      });
    }
  
    const naverUser = await getNaverUser(code);
  
    if(!naverUser){
      return res.status(400).json({
        code: 400,
        message: "no NaverUser.",
      });
    }
    
    const authUser = await updateOrCreateUser(naverUser);
  
    if(!authUser){
      return res.status(400).json({
        code: 400,
        message: "no User.",
      });
    }
  
    const firebaseToken = await admin
        .auth()
        .createCustomToken(authUser.uid, { provider: "Naver" });
    return res.status(200).json({ firebaseToken });
  }catch(error){
     return res.status(400).json({
        code: 400,
        message: `${error}`,
      });
  }
});

export default naverAuth
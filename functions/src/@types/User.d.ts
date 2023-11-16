interface KakaoProfile {
    nickname?: string;
    thumbnail_image_url?: string;
    profile_image_url?: string;
    is_default_image?: boolean;
}

interface KakaoAccount {
    profile?: KakaoProfile;
    name?: string;
    email?: string;
    birthday?: string;
    gender?: "male" | "female";
}

interface KakaoUser {
    id: number;
    kakao_account?: KakaoAccount;
}

interface NaverUser {
    id: string,
    nickname: string,
    profile_image: string,
    email: string
    name: string
}
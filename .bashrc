import type {
    APIMethods,
    APIMethodParams,
    TelegramAPIResponse,
} from "@gramio/types";

const TBA_BASE_URL = "https://api.telegram.org/bot";
const TOKEN = "8684473988:AAEVBXEFYPp4h2YK0E0X_UtTqG25mDeayZo";

const api = new Proxy({} as APIMethods, {
    get:
        <T extends keyof APIMethods>(_target: APIMethods, method: T) =>
        async (params: APIMethodParams<T>) => {
            const response = await fetch(`${TBA_BASE_URL}${TOKEN}/${method}`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(params),
            });

            const data = (await response.json()) as TelegramAPIResponse;
            if (!data.ok) throw new Error(`Some error occurred in ${method}`);

            return data.result;
        },
});

api.sendMessage({
    chat_id: 1,
    text: "message",
});
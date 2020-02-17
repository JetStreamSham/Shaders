Shader "Blends/ColorBlend"
{
    Properties
    {
		_Color1 ("Color1", Color) = (1,1,1,1)
		_Color2 ("Color2", Color) = (1,1,1,1)
		_Blend ("Blend", Range(0.0,1.0)) = 1.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag


            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

			fixed4 _Color1, _Color2;
			float _Blend;

			fixed4 frag(v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = lerp(_Color1,_Color2,_Blend);
                return col;
            }
            ENDCG
        }
    }
}
